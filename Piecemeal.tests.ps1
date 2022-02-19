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
                This extension extends a particular cmdlet
            #>            
            param(
            [Parameter(Mandatory)]
            [Management.Automation.Cmdlet("Get","Extension")]
            [int]$Int
            )
            $int
        } | Set-Content .\04.ext.ps1
    }
    context 'Get-Extension' {
        it '-ExtensionPath' {        
            $extensionList = Get-Extension -ExtensionPath $pwd
            $extensionList[0] | Select-Object -ExpandProperty Synopsis | Should -BeLike "Basic Extension*"
            $extensionList[1] | Select-Object -ExpandProperty Synopsis | Should -BeLike "Simple Extension*"
            $extensionList[2] | Select-Object -ExpandProperty Synopsis | Should -BeLike "Cmdlet Extension*"
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