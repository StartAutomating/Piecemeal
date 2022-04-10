@{
    ModuleVersion    = '0.2.1'
    RootModule       = 'Piecemeal.psm1'
    Description      = 'Easy Extensible Plugins for PowerShell'
    GUID             = '91e2c328-d7dc-44a3-aeeb-ef3b19c36767'
    Author           = 'James Brundage'
    Copyright        = '2021 Start-Automating'
    CompanyName      = 'Start-Automating'
    FormatsToProcess = 'Piecemeal.format.ps1xml'
    PrivateData      = @{
          PSData       = @{
              Tags         = 'PowerShell', 'Plugin', 'Extension', 'Extensibility'
              ProjectURI   = 'https://github.com/StartAutomating/Piecemeal'
              LicenseURI   = 'https://github.com/StartAutomating/Piecemeal/blob/main/LICENSE'
              ReleaseNotes = @'
## 0.2.1
* Get-Extension:  Support for -AllValid (#45)
* Get-Extension:  Removing Validation Errors when -ErrorAction is ignore (#43)
* Updating Piecemeal tests: Adding test for Steppable Pipeline (#42)
* Updating Piecemeal Formatting (making .Extends a list) (re #44)
* Get-Extension:  Support for SteppablePipelines (#42).  Fixing .Extends bug (#44)
---
## 0.2
* Adding formatting for extensions (#40)
* Updating Piecemeal tests (account for Regex) (#39)
* Get-Extension:  Regex support for [Cmdlet] attribute (#39)
* Get-Extension:  Adding -FullHelp, -ParameterHelp, -Example(s) (#38)
* Get-Extension:  Adding -Help (#38)
---

## 0.1.10
* Get-Extension:  Adding -ParameterSetName (#36)
* Install-Extension:  Adding -Force to Import-Module in Install Note (#32)
---

## 0.1.9
* Get-Extension: Fixing CouldRun/Run issue with multiple ParameterSets (with other attributes present) (#31)
---

## 0.1.8
* Get-Extension: Fixing CouldRun/Run issue with multiple ParameterSets (#31)
* Install-Piecemeal: Improving Install Message (#32)
---
## 0.1.7
* Get-Extension: Now inherits ParameterSetName (#28)
* Get-Extension: Fixing issue properly displaying Valid Set (#29)
---
## 0.1.6
* Get-Extension now supports all validation attributes (#26/#25)
---
## 0.1.5
* Extensions are now Sortable (#19)
* Get-Extension supports -ExtensionName (#20)
* Get-Extension/Install-Piecemeal renaming parameter -ExtensionNameRegex to -ExtensionPattern (#21)
* Get-Extension:  Adding -ValidateInput / Support for [ValidateScript], [ValidateSet], [ValidatePattern] (#22)
---
## 0.1.4
* Get-Extension:
  * Can now filter extension parameters based off of command (#17)
---

## 0.1.3
* Get-Extension:
  * Added -RequireExtensionAttribute (#13)
  * Added -RequireCmdletAttribute (#14)
  * Respecting [CmdletBinding(DefaultParameterSetName)] (#12)
  * Surfacing attributes (#11)
* Install-Piecemeal:
  * Allowing customization of -ExtensionName (#10)
  * Making $script variables unique (#9)
  * Fixing issues on Core (#16)
---
## 0.1.2
* Get-Extension:
  * Added -NoMandatoryDynamicParameter (#6 / #4)
  * [Parameter] attributes are now copied, so underlying commands are unchanged (#7)
---
## 0.1.1
* Get-Extension:
  * -Parameter not accepts ValueFromPipelineByPropertyName (#2)
  * -CommandName now works (#3)
  * .GetDynamicParameters now supports -NoMandatory (#4)
---
## 0.1
* Initial Release of Piecemeal
---
'@
          }
    }
}
