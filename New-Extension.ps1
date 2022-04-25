function New-Extension
{
    <#
    .Synopsis
        Creates an Extension
    .Description
        Creates an Extension
    .Example
        New-Extension -ExtensionName MyExtension -CommandName New-Extension -ScriptBlock {
            [ValidateScript({return $true})]
            param()
            "Hello World"
        }
    .Example
        New-Extension -Command
    .Link
        Get-Extension
    .Notes
        At this time, New-Extension assumes that it is not generating an indented script.
    #>
    param(
    # The name of the extension
    [Parameter(ValueFromPipelineByPropertyName)]
    [Alias('Name')]
    [string]
    $ExtensionName,

    [Parameter(ValueFromPipelineByPropertyName)]
    [Alias('ScriptContents', 'Definition')]
    [ScriptBlock]
    $ScriptBlock,

    # One or more commands being extended.
    [Parameter(ValueFromPipelineByPropertyName)]
    [string[]]
    $CommandName,

    # The extension module.  If provided, this will have to prefix the ExtensionNameRegex
    [Parameter(ValueFromPipelineByPropertyName)]
    [string]
    $ExtensionModule,

    # A collection of Extension Parameters.   
    # The key is the name of the parameter.  The value is any parameter type or attributes.
    [Parameter(ValueFromPipelineByPropertyName)]
    [Collections.IDictionary]
    $ExtensionParameter = [Ordered]@{},

    # A collection of Extension Parameter Help.
    [Parameter(ValueFromPipelineByPropertyName)]
    [Collections.IDictionary]
    $ExtensionParameterHelp = [Ordered]@{},

    # The type of the extension command.  By default, this is a script.
    [Parameter(ValueFromPipelineByPropertyName)]
    [ValidateSet('Script','Function', 'Filter')]
    [string]
    $ExtensionCommandType = 'Script',

    # The synopsis used for the extension.
    [Parameter(ValueFromPipelineByPropertyName)]    
    [string]
    $ExtensionSynopsis = 'Script',

    # Any help links for the extension.
    [Parameter(ValueFromPipelineByPropertyName)]    
    [string[]]
    $ExtensionLink,

    [Parameter(ValueFromPipelineByPropertyName)]
    [string[]]
    $ExtensionExample
    )

    dynamicParam {
        $myCmd = $MyInvocation.MyCommand
        Get-Extension -CommandName $myCmd -DynamicParameter  # Get any extensions to New-Extension
    }

    process {

        # New-Extension works by combining several script blocks together into one output.
        # Therefore, we start by creating a few lists to keep track of all of the combined parts of the final script.
        $combinedBegin   = @()
        $combinedParam   = @()
        $combinedProcess = @()
        $combinedEnd     = @()

        #region Run Extensions
        # Next, we create a copy of the bound parameters
        $myParams = @{} + $PSBoundParameters
        # and use it to see which extensions we -CouldRun.
        $couldRunExtensions  = Get-Extension -CouldRun -CommandName $myCmd -Parameter $myParams
        # If we could run any extensions, run them and assign their output.
        $ExtensionOutput     = if ($couldRunExtensions) { $couldRunExtensions | Get-Extension -Run }
        
        
        $combinedExtensionOutput = # Walk over each extension that ran.
            foreach ($extOut in $ExtensionOutput) { 
                # If the extension signaled it was done, output directly.                if ($extOut.Done) { $extOut.ExtensionOutput; continue } 
                # Otherwise, walk over each output from the extension.
                foreach ($extOutItem in $extOut.ExtensionOutput) {
                    if ($extOutItem -is [ScriptBlock]) {  # If the output was a ScriptBlock, combine it's parts.
                        $extOutAst = $extOut.ExtensionOutput.Ast                
                        $combinedParam   += $extOutItem.ParamBlock
                        $combinedBegin   += $extOutItem.BeginBlock.Statements
                        $combinedProcess += $extOutItem.ProcessBlock.Statements
                        $combinedEnd     += $extOutItem.EndBlock.Statements
                    }
                    if ($extOutItem -is [Collections.IDictionary]) { # If the output was a dictionary
                        # walk thru the dictionary
                        foreach ($extKey in $extOutItem.GetEnumerator()) {
                            # (skip any keys that are not parameters of this function).
                            if (-not $myCmd.Parameters[$extKey.Key]) { continue }
                            # If the parameter was an array, add the value to the array.
                            if ($myCmd.Parameters[$extKey.Key].ParameterType.IsSubclassOf([Array])) {
                                $ExecutionContext.SessionState.PSVariable.Set(
                                    $extKey.Key,
                                    $ExecutionContext.SessionState.PSVariable.Get($extKey.Key).Value + $extKey.Value
                                )
                            }
                            # If it the parameter and value were dictionaries
                            elseif ($myCmd.Parameters[$extKey.Key].ParameterType.GetInterface([Collections.IDictionary]) -and 
                                $extKey.Value -is [Collections.IDictionary]) {
                                # update the dictionary (overwriting values where found)
                                $dict = $ExecutionContext.SessionState.PSVariable.Get($extKey.Key).Value
                                foreach ($kv in $extKey.Value.GetEnumerator()) {
                                    $dict[$kv.Key] = $kv.Value
                                }
                            }
                            else {
                                # Otherwise, overwrite the parameter value.
                                $ExecutionContext.SessionState.PSVariable.Set($extKey.Key, $extKey.Value)
                            }                            
                        }
                    }
                }                
            }


        # If there was direct extension output, return it.
        if ($combinedExtensionOutput) { return $combinedExtensionOutput }
        #endregion Run Extensions
            
        #region construct Script
        if ($ExtensionParameter.Count) {
            # If extension parameters were passed, construct a parameter block for each
            foreach ($ep in $ExtensionParameter.GetEnumerator()) {
                $paramLines = @(
                    'param('
                    
                    "    " + $ep.Value
                    "    `$$($ep.Key -replace '^\$')"
                    ')'
                )
                $paramScriptBlock = [ScriptBlock]::Create($paramLines -join [Environment]::NewLine)
                $combinedParam += $paramScriptBlock.Ast.ParamBlock # and then add them to the combined output.
            }
        }

        if ($ScriptBlock) {  # If a -ScriptBlock was passed 
            $ast = $ScriptBlock.Ast
            if ($ast.Body) {
                $ast= $ast.Body
            }
            # add it's parts to the combined output.
            $combinedParam   += $ast.ParamBlock
            $combinedBegin   += $ast.BeginBlock.Statements
            $combinedProcess += $ast.ProcessBlock.Statements
            $combinedEnd     += $ast.EndBlock.Statements
        }

        $extensionLines = @(

            # If the extension command type was function or filter, write that first
            if ($ExtensionCommandType -in 'Function', 'Filter') {
                $ExtensionCommandType -in 'Function', 'Filter'
                $ExtensionCommandType.ToLower() + " $ExtensionName" + '{'
            }            

            # If the extension synopsis and description were provided, add help.
            if ($ExtensionSynopsis -and $extensionDescription) {
                "<#"
                ".SYNOPSIS"
                $ExtensionSynopsis
                ".DESCRIPTION"
                $ExtensionDescription
                if ($extensionExample) { # If there were examples, include them.
                    foreach ($example in $extensionExample) {
                        ".EXAMPLE"
                        $example
                    }
                }
                if ($extensionLink) {  # If there were links, include them.
                    foreach ($extLink in $extensionLink) {
                        ".LINK"
                        $extLink
                    }                    
                }
                "#>"
            }

            if ($CommandName) {  # If one or more command names have provided
                foreach ($extCmdName in $CommandName) {
                    $extVerb, $extNoun  = $extCmdName -split '-'
                    if (-not $extNoun) { $extNoun = ' '}
                    # add a cmdlet attribute
                    "[Management.Automation.Cmdlet('$extVerb','$extNoun')]"
                }
            }

            if ($combinedParam) { # If any combined params have attributes
                foreach ($combined in $combinedParam) {
                    if ($combinedParam.Attributes) {
                        foreach ($attr in $combinedParam.Attributes) {
                            $attr.Extent.ToString() # include them before the param block.
                        }
                    }
                }
            }
            # Start the param block
            "param("
            if ($combinedParam) {
                @(foreach ($combined in $combinedParam) {
                    # Include any existing parameters                                    
                    foreach ($parameter in $combined.parameters) {
                        $parameterName = $parameter.Name.VariablePath.ToString()
                        @(
                            # If the parameter had help, include it
                            if ($ExtensionParameterHelp[$parameterName]) {
                                $lineCount = @([Regex]::Matches($ExtensionParameterHelp[$parameterName], '\n')).Count
                                if ($lineCount) { # (multiline help goes in block comments,
                                    "<#"
                                    $ExtensionParameterHelp[$parameterName]
                                    "#>"
                                } else {
                                    # singleline help goes in line comments)
                                    "# " + $ExtensionParameterHelp[$parameterName]
                                }
                            }
                            $parameter.Extent.ToString()
                        ) -join [Environment]::NewLine
                    }                    
                }) -join (',' + ([Environment]::NewLine * 2))
            }
            ")"

            
            if ($combinedBegin) {  # If there were begin blocks,
                "begin {"          # create a begin block
                @(foreach ($combined in $combinedBegin) { 
                    "$combined"    # combine the statements with two newlines.
                }) -join ([Environment]::NewLine * 2)
                "}"                # and close the block.
            }

            if ($combinedProcess) {  # If there were process blocks
                "process {"          # create a process block
                @(foreach ($combined in $combinedProcess) {
                    "$combined"      # combine the statements with two newlines.
                }) -join ([Environment]::NewLine * 2)
                "}"                  # and close the block.
            }

            if ($combinedEnd) {
                # If there were end blcoks declared
                $beginOrProcess = $combinedParam -or $combinedBegin
                if ($beginOrProcess) { # create an end block (if there was a begin or process block),
                    "end {"
                }
                @(foreach ($combined in $combinedEnd) {
                    "$combined" # combine all of the statements with two newlines
                }) -join ([Environment]::NewLine * 2)
                if ($beginOrProcess) {
                    "}" # and close the block (if needed).
                }
            }

            # If the command type was a function or a filter, close the command.
            if ($ExtensionCommandType -in 'Function', 'Filter') {
                $ExtensionCommandType -in 'Function', 'Filter'
                '}'
            }
        )

        # Combine all of the lines, and voila, new extension.
        $ExtensionScript = $extensionLines -join [Environment]::NewLine
        $ExtensionScript
        #endregion construct Script
    }    
}
