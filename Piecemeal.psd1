@{
    ModuleVersion    = '0.3.1'
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
## 0.3.1:
* Get-Extension:
   * New Properties/Methods for Each Extension
     * .Category (#89)
     * .GetHelpField() (#91)
     * .Examples (#87)
     * .Links    (#88)
     * .Metadata (#90)
   * Removing -RequireExtensionAttribute (#92)
---

## 0.3.0:
* Get-Extension:
  * Ensuring Regexes IgnoreCase (#85)
  * Trimming Trailing Whitepace from .Synopsis and .Description (#84)
---  
## 0.2.9.1:
* Fixing Get-Extension overcollection (#82)
---

## 0.2.9:
* Get-Extension:
   * -CouldRun now honors validation attributes (#77)
   * -CouldPipe now honors validation attributes (#78)
   * -ExtensionName now supports Regex Literal Aliases ```[Alias(/Expression/)]``` (#80)
   * -CouldRun, -CouldPipe, -Validate are no longer mutually exclusive (#79)
* Install-Piecemeal
   * Support for custom -WhereObject (#73)            
   * Support for custom -ForeachObject (#74)
---

## 0.2.8
* Get-Extension:  
  * Performance Improvements (#75)
  * Regular Expressions now IgnorePatternWhitespace (#71)
  * -ExtensionPattern allows for multiple patterns (#70)
  * Allowing any command type (#65)
* Install-Piecemeal:
  * Adding -RenameVariable (#72)
  * Automatically renaming parameters when -ExtensionNoun is provided (#60) 
---
## 0.2.7
* Get-Extension
  * Allowing any command type (#65)
  * Fixing -CouldPipe (#67)
---
## 0.2.6
* Get-Extension:
  * Matching -ExtensionName support aliases (#63)
  * Matching -ExtensionName against .DisplayName or .Name (#61)
  * Get-Extension:  -CouldPipe no longer cares about manadatory parameters (#62)
---
## 0.2.5
* Get-Extension:  Adding -CouldPipe (#58)
* Get-Extension:  Fixing .Tags based inclusion (#57)
---
## 0.2.4
* Install-Piecemeal:  Making -ExtensionModule Optional (#54)
---
## 0.2.3
* Adding New-Extension (#51)
* Generating Docs (#52)
* Allowing New-Extension to be installed with Install-Piecemeal
---

## 0.2.2
* Adding test for [ValidateScript] (#47)
* Updating Piecemeal tests (checking validation order) (#48)
* Get-Extension:  Fixing -ValidateInput logic (#48)
* Get-Extension:  Fixing support for [ValidateScript] (#47)
---

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
