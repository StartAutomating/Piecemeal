@{
    ModuleVersion = '0.1.1'
    RootModule    = 'Piecemeal.psm1'
    Description   = 'Easy Extensible Plugins for PowerShell'
    GUID          = '91e2c328-d7dc-44a3-aeeb-ef3b19c36767'
    Author        = 'James Brundage'
    Copyright     = '2021 Start-Automating'
    PrivateData   = @{
            PSData    = @{
                Tags       = 'PowerShell', 'Plugin', 'Extension', 'Extensibility'
                ProjectURI = 'https://github.com/StartAutomating/Piecemeal'
                LicenseURI = 'https://github.com/StartAutomating/Piecemeal/blob/main/LICENSE'
                ReleaseNotes = @'
## 0.1.1
---
* Get-Extension:
  * -Parameter not accepts ValueFromPipelineByPropertyName (#2)
  * -CommandName now works (#3)
  * .GetDynamicParameters now supports -NoMandatory (#4)

## 0.1
---
* Initial Release of Piecemeal

'@
            }
    }
}
