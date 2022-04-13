Push-Location $PSScriptRoot
describe Piecemeal {    
    beforeAll {
        {
            <#
            .Synopsis
                Basic Extension
            .Description
                This is about as basic of an extension as you can have
            #>            
        } | Set-Content .\01.ext.ps1


        {
            <#
            .Synopsis
                Simple Extension
            .Description
                This just has one parameter, $int, and it outputs $int
            #>
            [Reflection.AssemblyMetaData("Rank",2)]
            param(
            [int]$Int
            )
            $int
        } | Set-Content .\02.ext.ps1

        {
            <#
            .Synopsis
                Cmdlet Extension
            .Description
                This extension extends a particular cmdlet
            #>
            [Management.Automation.Cmdlet("Get","Extension")]
            param(
            [Parameter(Mandatory)]
            [int]$Int
            )
            $int
        } | Set-Content .\03.ext.ps1

        {
            <#
            .Synopsis
                Cmdlet Extension
            .Description
                This extension extends any cmdlet whose name starts with g
            #>            
            param(
            [Parameter(Mandatory)]
            [Management.Automation.Cmdlet('^g',"Extension")]
            [int]$Int
            )
            $int
        } | Set-Content .\04.ext.ps1

        {
            [ValidateSet('a','aa')]
            [ValidatePattern('a{1,}')]
            [ValidateScript({if ($_ -like 'a*' -and $_ -notlike 'aa*') { return $true } else { return $false }})]            
            param()
        } | Set-Content .\05.ext.ps1

        {
            [CmdletBinding(DefaultParameterSetName='Foo')]
            param(
            [Parameter(Mandatory,ParameterSetName='Foo')]
            [string]
            $Foo,

            [Parameter(Mandatory,ParameterSetName='Bar')]
            [string]
            $Bar
            )
        } | Set-Content .\06.ext.ps1

        {
            <#
            .SYNOPSIS
            .DESCRIPTION
            #>
            param(            
            [string]
            $Foo,

            [Parameter(ValueFromPipelineByPropertyName)]
            [string]
            $Bar
            )

            begin {
                'foo'
            }
            process {
                $bar
            }   
            end {
                $foo
            }
        } | Set-Content .\07.ext.ps1
    }
    context 'Get-Extension' {
        it '-ExtensionPath' {        
            $extensionList = Get-Extension -ExtensionPath $pwd
            # Results without a rank will come alphabetically
            $extensionList[0] | Select-Object -ExpandProperty Synopsis | Should -BeLike "Basic Extension*"
            $extensionList[1] | Select-Object -ExpandProperty Synopsis | Should -BeLike "Cmdlet Extension*" 
            # SimpleExtension has a rank, to test this aspect of Piecemeal.
            $extensionList[-1] | Select-Object -ExpandProperty Synopsis | Should -BeLike "Simple Extension*"
        }

        it '-CommandName' {
            Get-Extension -ExtensionPath $pwd -CommandName Get-Extension |
                Select-Object -ExpandProperty Synopsis -First 1 |
                Should -BeLike "Cmdlet Extension*"
        }

        it '-DynamicParameter' {
            Get-Extension -ExtensionPath $pwd -CommandName Get-Extension -DynamicParameter |
                Select-Object -ExpandProperty Keys -First 1 | 
                Should -Be "Int"
        }

        it '-NoMandatoryDynamicParameter' {
            Get-Extension -ExtensionPath $pwd -CommandName Get-Extension -DynamicParameter -NoMandatoryDynamicParameter |
                Select-Object -ExpandProperty Values -First 1 | 
                Select-Object -ExpandProperty Attributes |
                Where-Object Position -GE 0 |
                Select-Object -ExpandProperty Mandatory |
                Should -Be $false 
        }

        it 'Can exclude parameters if they are not for the right command' {
            $x  = Get-Extension -ExtensionPath $pwd | Where-Object Name -like 04*
            $x | Get-Extension -DynamicParameter -CommandName Get-Extension | 
                Select-Object -ExpandProperty Keys | 
                Select-Object -First 1 |
                Should -Be "int"
            $x | Get-Extension -DynamicParameter -CommandName New-Extension | Select-Object -ExpandProperty Count | Should -Be 0
        }

        it 'Can -ValidateInput' {
            $ev = $null
            Get-Extension -ExtensionPath $pwd -ExtensionName 05* -Like -ValidateInput c -ErrorVariable ev -ErrorAction SilentlyContinue | 
                Should -Be $null
            
            Get-Extension -ExtensionPath $pwd -ExtensionName 05* -Like -ValidateInput c -ErrorVariable ev -ErrorAction SilentlyContinue -AllValid | 
                Should -Be $null
            $ev | ForEach-Object { $_ | Should -BeLike "*'c'*'a'*" }

            Get-Extension -ExtensionPath $pwd -ExtensionName 05* -Like -ValidateInput aa -ErrorVariable ev -ErrorAction SilentlyContinue -AllValid | 
                Should -Be $null
            $ev | ForEach-Object { $_ | Should -BeLike "*'aa'*" }
            Get-Extension -ExtensionPath $pwd -ExtensionName 05* -Like -ValidateInput a | 
                Select-Object -ExpandProperty Name | 
                Should -BeLike 05*
            
        }

        it 'Can keep the parameter set when getting -DynamicParameter' {
            $dp  = Get-Extension -ExtensionPath $pwd -ExtensionName 06* -Like -DynamicParameter
            $dp.Values |
                Select-Object -ExpandProperty Attributes |
                Where-Object ParameterSetName |
                Select-Object -ExpandProperty ParameterSetName |
                Should -Match 'Foo|Bar'

            Get-Extension -ExtensionPath $pwd -ExtensionName 06* -Like -CouldRun -Parameter @{"foo"="foo"} | Should -Not -Be $null
            Get-Extension -ExtensionPath $pwd -ExtensionName 06* -Like -CouldRun -Parameter @{"bar"="bar"} | Should -Not -Be $null
            Get-Extension -ExtensionPath $pwd -ExtensionName 06* -Like -CouldRun -Parameter @{"foog"="foo"} | Should -Be $null
        }

        it 'Can use a -SteppablePipeline' {
            $sp  = Get-Extension -ExtensionPath $pwd -ExtensionName 07* -Like -SteppablePipeline -Parameter @{foo='foo'}
            $sp.Begin($true) 
            $sp.Process([PSCustomObject]@{Bar='bar'}) | Should -Be @('Foo','Bar')
            $sp.End() | Should -be 'Foo'
        }
    }

    context 'Install-Piecemeal' {
        it '-ExtensionModule' {
            Install-Piecemeal -ExtensionModule TestModule -ExtensionModuleAlias tm -ExtensionTypeName Test.Extension | 
                Invoke-Expression

            Get-Command Get-TestModuleExtension
        }
    }
       
    afterAll {
        Get-ChildItem -Path $pwd -Filter *.ext.ps1 | Remove-Item
    }
}
Pop-Location