﻿function Install-Piecemeal
{
    <#
    .Synopsis
        Installs Piecemeal
    .Description
        Installs Piecemeal into a module.

        This enables extensibility within the module.
    .Notes
        This returns a modified Get-Extension
    .Example
        Install-Piecemeal -ExtensionModule RoughDraft -ExtensionModuleAlias rd -ExtensionTypeName RoughDraft.Extension
    .EXAMPLE
        Install-Piecemeal -ExtensionNoun 'PipeScript' -ExtensionPattern '\.psx\.ps(?<IsPowerShell>1{0,1})$','\.ps(?<IsPowerShell>1{0,1})\.(?<Extension>[^.]+$)','\.ps(?<IsPowerShell>1{0,1})$' -OutputPath '.\Get-PipeScript.ps1' -RenameVariable @{ExtensionPath='PipeScriptPath'}
    .Link
        Get-Extension
    #>
    [OutputType([string], [IO.FileInfo])]
    param(
    # The name of the module that is being extended.
    [Parameter(ValueFromPipelineByPropertyName)]
    [string]
    $ExtensionModule,

    # The verbs to install.  By default, installs Get.
    [Parameter(ValueFromPipelineByPropertyName=$true)]
    [ValidateSet('Get','New')]
    [string[]]
    $Verb = @('Get'),

    # One or more aliases used to refer to the module being extended.
    [Parameter(ValueFromPipelineByPropertyName)]
    [string[]]
    $ExtensionModuleAlias,

    # If provided, will override the default extension name regular expression
    # (by default '(extension|ext|ex|x)\.ps1$' )
    [Parameter(ValueFromPipelineByPropertyName)]
    [Alias('ExtensionNameRegEx', 'ExtensionPatterns')]
    [string[]]
    $ExtensionPattern = '(?<!-)(extension|ext|ex|x)\.ps1$',

    # The type name to add to an extension.  This can be used to format the extension.
    [Parameter(ValueFromPipelineByPropertyName)]
    [string]
    $ExtensionTypeName,

    # The noun used for any extension commands.
    [Parameter(ValueFromPipelineByPropertyName)]
    [string]
    $ExtensionNoun,

    # If set, will require a [Management.Automation.Cmdlet] attribute to be considered an extension.
    # This attribute can associate the extension with one or more commands.
    [Parameter(ValueFromPipelineByPropertyName)]
    [switch]
    $RequireCmdletAttribute,

    # The output path.
    # If provided, contents will be written to the output path with Set-Content
    # Otherwise, contents will be returned.
    [Parameter(ValueFromPipelineByPropertyName)]
    [string]
    $OutputPath,
    
    # If provided, will rename variables.
    [Parameter(ValueFromPipelineByPropertyName)]
    [Collections.IDictionary]
    $RenameVariable = @{},
    
    # A custom Foreach-Object that will be appended to main pipelines within Get-Extension.
    [ScriptBlock[]]
    $ForeachObject,

    # A custom Where-Object that will be injected to the main pipelines within Get-Extension
    [ScriptBlock[]]
    $WhereObject
    )

    begin {
        $myModule        = $MyInvocation.MyCommand.Module
        ${?<CurlyBrace>} = [Regex]::new('{(?<TrailingWhitespace>\s{0,})(?<Newline>[\r\n]{0,})?(?<Indent>\s{0,})?','Multiline')
        ${?<Indent>}     = [Regex]::new('^\s{0,}', 'Multiline,RightToLeft')

        function FindRegion {
            param(            
            [Parameter()]
            [string]
            $RegionName = $(
                '(?:.|\s)+?(?=\z|\s{0,}$)' # Matches anything until whitespace and the end of line.
                # This prevents trailing whitespace from failing to pair the match, but allows whitespace within the region name
            )
            )
                
                
            if ($PSBoundParameters['RegionName']) {
                $RegionName = $RegionName -replace '\s', '\s'
            }
                
            [Regex]::New("        
            [\n\r\s]{0,}        # Preceeding whitespace
            \#region            # The literal 'region'
            \s{1,} 
            (?<Name>$RegionName)
                (?<Content>
                    (?:.|\s)+?(?=
                    \z|
                    ^\s{0,}\#endregion\s\k<Name>
                )
            )
            ^\s{0,}\#endregion\s\k<Name>
            ", 'Multiline,IgnorePatternWhitespace,IgnoreCase')
                            
        }
    }

    process {
        $myParams = [Ordered]@{} + $PSBoundParameters
        $myOutput = [Text.StringBuilder]::new()
        # Walk over each command this module exports.
        foreach ($exported in $myModule.ExportedCommands.Values) {
            # If the command is not a verb we're exporting, skip it.
            if ($exported.Verb -notin $Verb) { continue }


            # Copy the original text
            $commandString = $exported.ScriptBlock.Ast.ToString()
            # get the tokens (which have comments)
            $commandTokens = [Management.Automation.PSParser]::Tokenize($commandString, [ref]$null)
            # and get the parameters from the abstract syntax tree.
            $paramsAst = $exported.ScriptBlock.Ast.FindAll({param($ast) $ast -is [Management.Automation.Language.ParameterAst]}, $true)

            # Create a collection of default parameters and their values.
            # We will declare these as variables within the copy of the function.
            $defaultParameters = [Ordered]@{}

            $skipParameters = @( # Next, make a list of parameters we will skip
                foreach ($statement in $paramsAst) {
                    # (any parameters declared by this function).
                    if ($statement.Name.VariablePath.UserPath -and
                        $MyInvocation.MyCommand.Parameters[$statement.Name.VariablePath.UserPath]
                    ) {
                        $statement
                   }
                }
            )

            # Now we start modifying the script
            $lengthChange = 0 # (keeping track of how much we change the length)
            #region Extract Skipped Parameters
            foreach ($skipParam in $skipParameters) {
                # Keep track of what we're skipping
                $toSkip       = $skipParam.Extent
                if ($skipParam.DefaultValue) { # If it had a default value
                    $defaultParameters["$($skipParam.Name)"] = "$($skipParam.DefaultValue)" # save it for later.
                }
                # Determine the figure out the length of the removal, according to the AST.
                $removeLength = $toSkip.EndOffset - $toSkip.StartOffset
                # If the parameter we're removing was immediately followed by a comma
                $immediatelyFollowedBy = $commandString[$toSkip.StartOffset + $removeLength - $lengthChange]
                if ($immediatelyFollowedBy -eq ',') {
                    $removeLength += 1 # adjust the removed length
                }
                # Find all of the tokens that came before this point
                $beforeTokens = @($commandTokens | Where-Object Start -lt $toSkip.StartOffset)
                for ($i = -1; $i -gt -$beforeTokens.Length; $i--) {
                    # we'll also want to remove any newlines or comments above the parameter
                    if ($beforeTokens[$i].Type -notin 'Comment','Newline') {
                        break
                    }
                }

                # Adjust the pointer accordingly
                $realStart     = $beforeTokens[$i - 1].Start + $beforeTokens[$i - 1].Length + 1
                $removeLength += $toSkip.StartOffset - $realStart

                # Remove the content
                $changed = $commandString.Remove(
                    $realStart - $lengthChange,
                    $removeLength
                )

                # Keep track of how much was removed
                $lengthChange += $removeLength

                # And update the command
                $commandString = $changed
            }
            #endregion Extract Skipped Parameters

            $insertIntoBlock = # We will insert parameters into the the first block that will run.
                foreach ($blockName in 'DynamicParam', 'Begin', 'Process', 'End') {
                    if ($exported.ScriptBlock.Ast.Body."${blockName}Block") {
                        $exported.ScriptBlock.Ast.Body."${blockName}Block"; break
                    }
                }

            # Our pointer starts at the beginning of the block (minus what we've removed, plus the name of the block's length)
            $insertPoint = $insertIntoBlock.Extent.StartOffset - $lengthChange + "$($insertIntoBlock.BlockKind.Length)"
            # We find the next curly brace
            $foundCurly  = ${?<CurlyBrace>}.Match($commandString, $insertPoint)
            $indentLevel = 0
            if ($foundCurly.Success) {
                $insertPoint = $foundCurly.Index  + $foundCurly.Length # then adjust our insertion point by this
                $indentLevel = ${?<Indent>}.Match($commandString, $insertPoint).Length # determine the indent
                $insertPoint -= $indentLevel # and then subtract it so we're inserting at the beginning of the line.
            }

            # Walk over each parameter passed in.
            foreach ($myParam in $myParams.GetEnumerator()) {
                $defaultParameters["`$$($myParam.Key)"] =  # and assign them a default value.
                    if ($null -ne ($myParam.Value -as [float])) {
                        "$($myParam.Value)"
                    } elseif ($myParam.Value -is [Array]) {
                        "'$(@(foreach ($v in $myParam.Value) { "$v".Replace("'","''") }) -join "','")'"
                    }
                    else {
                        "'$($myParam.Value.ToString().Replace("'","''"))'"
                    }
            }

            $insertion = # Then, take all parameters that would be exported by the command
                @(foreach ($defaultParam in $defaultParameters.GetEnumerator()) {
                    if (-not $exported.Parameters.($defaultParam.Key -replace '^\$')) { continue }
                    # and put one declaration per line.
                    "$(' ' * $indentLevel)$($defaultParam.Key) = $($defaultParam.Value)"
                }) -join [Environment]::NewLine
            # Add one more newline so that the original text is still indented.
            $insertion += [Environment]::NewLine


            $extensionCommandReplacement =
                if ($ExtensionNoun) {
                    "`$1-$ExtensionNoun"
                } elseif ($ExtensionModule) {
                    "`$1-$ExtensionModule`$2"
                } else {
                    "`$1-Extension"
                }

            $extensionVariableReplacer =
                if ($ExtensionNoun) {
                    "`$script:${ExtensionNoun}s"
                } elseif ($ExtensionModule) {
                    "`$script:${ExtensionModule}Extensions"
                } else {
                    "`$script:Extensions"
                }

            $otherDashReplacment = "-$(
                if ($ExtensionNoun) {
                    "$ExtensionNoun"
                } elseif ($ExtensionModule) {
                    "${ExtensionModule}Extension"
                } else {
                    "Extension"
                })"

            $newCommand = $commandString.Insert($insertPoint, $insertion) -replace # Finally, we insert the default values
                "($($exported.Verb))-($($exported.Noun))", $extensionCommandReplacement -replace # change the name
                '\$script:Extensions', $extensionVariableReplacer -replace # change the inner variable references,
                " Extensions ", " $(if ($ExtensionNoun) { $ExtensionNoun } else { $ExtensionModule + 'Extensions'}) " -replace # and update likely documentation mentions
                "-Extension", $otherDashReplacment

            $null = $myOutput.AppendLine($newCommand)

            if ($ExtensionNoun) {
                foreach ($paramName in $exported.Parameters.Keys) {
                    if ($paramName -match 'Extension') {
                        $RenameVariable[$paramName] = $paramName -replace 'Extension', $ExtensionNoun
                    }
                }
            }
        }

        


        $myOutput =
            if (-not $NoLogo) {
                $installInstructions =
                    @(
                    "Install-Module $($myModule.Name) -Scope CurrentUser"
                    "$([Environment]::NewLine)# Import-Module $($myModule.Name) -Force"
                    "$([Environment]::NewLine)# $($MyInvocation.MyCommand.Name)"
                    $(if ($myParams.Verb) {"-Verb $($verb -join ',')"})
                    @(foreach ($kv in $myParams.GetEnumerator()) {
                        if ($kv.Value -is [switch] -and $kv.Value) {
                            "-$($kv.Key)"
                        } elseif ($kv.Value -is [string]) {
                            "-$($kv.Key) '$($kv.Value)'"
                        } elseif ($kv.Value -is [string[]]) {
                            "-$($kv.Key) '$($kv.Value -join "','")'"
                        } elseif ($kv.Value -is [Collections.IDictionary]) {
                            "-$($kv.Key) @{$(                                
                                @(
                                    foreach ($ikv in $kv.Value.GetEnumerator()) { 
                                        '' + $ikv.Key + '=' + "'" + "$($ikv.Value)".Replace("'","''") + "'"
                                    }
                                ) -join ';'
                            )}"
                        }
                    }) | Sort-Object
                    ) -join ' '
                $logo = @(
                    $myModule.Name
                    '['
                    $myModule.Version
                    ']'
                    ':'
                    $myModule.Description
                ) -join ' '
                $null = $myOutput.Insert(0, ("#region $logo" + [Environment]::NewLine + "# $installInstructions" + [Environment]::NewLine))
                $null = $myOutput.AppendLine("#endregion $logo")
                "$myOutput"
            } else {
                "$myOutput"
            }

        
        if ($ForeachObject) {
            $regionFinder = FindRegion -RegionName "Install-Piecemeal -ForeachObject"
            $myOutput = $regionFinder.Replace($myOutput, {
                '|' + [Environment]::NewLine +
                    @(foreach ($foreachStatement in $ForeachObject) {
                        if ($foreachStatement.Ast.ProcessBlock -or $foreachStatement.Ast.BeginBlock) {
                            ". {$ForeachStatement}"
                        } elseif ($foreachStatement.Ast.EndBlock.Statements -and 
                            $foreachStatement.Ast.EndBlock.Statements[0].PipelineElements[0].CommandElements -and
                            $foreachStatement.Ast.EndBlock.Statements[0].PipelineElements[0].CommandElements.Value -in 'Foreach-Object', '%') {
                            "$ForeachStatement"
                        } else {
                            "Foreach-Object {$ForeachStatement}"
                        }
                    }) -join (' |' + [Environment]::NewLine)
            })
        }

        if ($WhereObject) {
            $regionFinder = FindRegion -RegionName "Install-Piecemeal -WhereObject"
            $myOutput = $regionFinder.Replace($myOutput, {                
                $(
                    @(foreach ($whereStatement in $WhereObject) {
                    if ($whereStatement.Ast.ProcessBlock -or $whereStatement.Ast.BeginBlock) {
                        "& {$whereStatement}"
                    } elseif ($whereStatement.Ast.EndBlock.Statements -and 
                        $whereStatement.Ast.EndBlock.Statements[0].PipelineElements[0].CommandElements -and
                        $whereStatement.Ast.EndBlock.Statements[0].PipelineElements[0].CommandElements.Value -in 'Where-Object', '?') {
                        "$whereStatement"
                    } else {
                        "Where-Object {$whereStatement}"
                    }
                    }) -join (' |' + [Environment]::NewLine)
                    ' |'
                )
            })
        }

        $newScriptBlock = [ScriptBlock]::Create($myOutput)
        $newScriptBlockText = "$newScriptBlock"

        if ($newScriptBlock -and $RenameVariable.Count) {
            $TextReplacement = [Ordered]@{}
            $variablesToRename = @($newScriptBlock.Ast.FindAll({
                param($ast)
                if ($ast -isnot [Management.Automation.Language.VariableExpressionast]) { return $false }                
                if ($RenameVariable.Contains("$($ast.VariablePath)")) { return $true}
                return $false
            }, $true))
            
            $myOffset = 0            
            foreach ($var in $variablesToRename) {
                $renameToValue = $RenameVariable["$($var.VariablePath)"]
                $start = $newScriptBlockText.IndexOf($var.Extent.Text, $myOffset)
                $end   = $start + $var.Extent.Text.Length
                $TextReplacement["$start,$end"] = 
                    if ($var.Splatted) {
                        '@' + ($renameToValue -replace '^[\$\@]')
                    } else {
                        '$' + ($renameToValue -replace '^[\$\@]')
                    }
                
                $myOffset = $end
            }


            $newText = @(
                $index = 0
                foreach ($tr in $TextReplacement.GetEnumerator()) {
                    $start, $end = $tr.Key -split ',' -as [int[]]
                    if (-not $start -and -not $end ) { continue }
                    if ($start -gt $index) {
                        $newScriptBlockText.Substring($index, $start - $index)
                    }
                    $tr.Value
                    $index = $end
                }
                if ($index -lt $newScriptBlockText.Length) {
                    $newScriptBlockText.Substring($index)
                }
            )

            $newScriptBlock = [scriptblock]::Create($newText -join '')
        }

        if ($OutputPath) {
            "$newScriptBlock" | Set-Content -Path $OutputPath
            Get-Item -Path $OutputPath
        } else {
            $newScriptBlock
        }
    }
}
