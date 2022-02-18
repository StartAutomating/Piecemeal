## 0.1.3
---
* Get-Extension:
  * Added -RequireExtensionAttribute (#13)
  * Added -RequireCmdletAttribute (#14)
  * Respecting [CmdletBinding(DefaultParameterSetName)] (#12)
  * Surfacing attributes (#11)
* Install-Piecemeal:
  * Allowing customization of -ExtensionName (#10)
  * Making $script variables unique (#9)
  * Fixing issues on Core (#16)

## 0.1.2
---
* Get-Extension:
  * Added -NoMandatoryDynamicParameter (#6 / #4)
  * [Parameter] attributes are now copied, so underlying commands are unchanged (#7)

## 0.1.1
---
* Get-Extension:
  * -Parameter not accepts ValueFromPipelineByPropertyName (#2)
  * -CommandName now works (#3)
  * .GetDynamicParameters now supports -NoMandatory (#4)

## 0.1
---
* Initial Release of Piecemeal
