## Piecemeal@0.4:

* Enabling Sponsorship for Piecemeal (#139)
* Improving -ExtensionName performance (#138)
* Not recursing when -ExtensionPath is local (#137)

---

## Piecemeal@0.3.10:
### Piecemeal Performance Improvements

* Checking before extending objects (Fixes #134)
* No Longer Allowing A Cmdlet to be an Extension (Fixes #133)
* Improving the performance of .Extends/ .ExtensionCommands (Fixes #132)
* Improving Terseness related performance (Fixes #131)
* Caching Extensions from Files until the File Changes (Fixes #130)
* Improving the performance of Get-Extension without -CommandName (Fixes #129)

---

## Piecemeal@0.3.9:

* Allowing any command to be an extension! (Fixes #120)

Functions, Cmdlets, and Aliases that meet the the naming convention will be seen as extensions by Get-Extension.

In most cases, this allows extensions to be defined in memory or on disk.

* Allowing .DisplayName to be set (Fixes #123)
* Adding .CouldPipeType to all extensions (Fixes #121)
* Not allowing a directories to be extensions (for now) (Fixes #125)
* Not clearing an extension's .PSTypeNames (inserting instead) (Fixes #126)

---

## Piecemeal@0.3.8:

* Adding .HasValidation to all extensions (Fixes #117)
* All extension methods and properties are now prevalidated in case of collision (Fixes #118)

---

## Piecemeal@0.3.7:

* Get-Extension:  Stringifying input for ValidatePattern (Fixes #114)

---

## Piecemeal@0.3.6:

* Get-Extension -CouldPipe can now handle PSTypeName attributes (Fixes #109)
* Piecemeal action no longer produces output variables (Fixes #110)
* Now Publishing with [GitPub](https://github.com/StartAutomating/GitPub) (Fixes #111)

---

## Piecemeal@0.3.5:
* GitHub Action now checks if it is on a branch (Fixes #107)

---

## Piecemeal@0.3.4:
* Get-Extension
  * Adding -Force (Fixes #103)
  * Caching allCommands (Fixes #104)
  * Only allowing Functions, Aliases, and Cmdlets to be extended (Fixes #105)

---

## Piecemeal@0.3.3:
* Consolidating -Help parameters (#101)
* Fixing .GetHelpField (#100)

---

## Piecemeal@0.3.2:
* Piecemeal Available as a GitHub Action (#56)
* Get-Extension:
  * Adding .BlockComments property (#96)
  * Fixing GetHelpField whitespace (#95)
  * Scoping GetHelpField matches to .BlockComments (#94)
  * Trimming leading whitespace from .Synopsis and .Description (#99)
* Install-Piecemeal:
  * Returns a file when -OutputPath is passed (#97)

---

## Piecemeal@0.3.1:
* Get-Extension:
   * New Properties/Methods for Each Extension
     * .Category (#89)
     * .GetHelpField() (#91)
     * .Examples (#87)
     * .Links    (#88)
     * .Metadata (#90)
   * Removing -RequireExtensionAttribute (#92)

---

## Piecemeal@0.3.0:
* Get-Extension:
  * Ensuring Regexes IgnoreCase (#85)
  * Trimming Trailing Whitepace from .Synopsis and .Description (#84)

---  

## Piecemeal@0.2.9.1:
* Fixing Get-Extension overcollection (#82)

---

## Piecemeal@0.2.9:
* Get-Extension:
   * -CouldRun now honors validation attributes (#77)
   * -CouldPipe now honors validation attributes (#78)
   * -ExtensionName now supports Regex Literal Aliases ```[Alias(/Expression/)]``` (#80)
   * -CouldRun, -CouldPipe, -Validate are no longer mutually exclusive (#79)
* Install-Piecemeal
   * Support for custom -WhereObject (#73)            
   * Support for custom -ForeachObject (#74)

---

## Piecemeal@0.2.8
* Get-Extension:  
  * Performance Improvements (#75)
  * Regular Expressions now IgnorePatternWhitespace (#71)
  * -ExtensionPattern allows for multiple patterns (#70)
  * Allowing any command type (#65)
* Install-Piecemeal:
  * Adding -RenameVariable (#72)
  * Automatically renaming parameters when -ExtensionNoun is provided (#60) 

---

## Piecemeal@0.2.7
* Get-Extension
  * Allowing any command type (#65)
  * Fixing -CouldPipe (#67)

---

## Piecemeal@0.2.6
* Get-Extension:
  * Matching -ExtensionName support aliases (#63)
  * Matching -ExtensionName against .DisplayName or .Name (#61)
  * Get-Extension:  -CouldPipe no longer cares about manadatory parameters (#62)

---

## Piecemeal@0.2.5
* Get-Extension:  Adding -CouldPipe (#58)
* Get-Extension:  Fixing .Tags based inclusion (#57)

---

## Piecemeal@0.2.4
* Install-Piecemeal:  Making -ExtensionModule Optional (#54)

---

## Piecemeal@0.2.3
* Adding New-Extension (#51)
* Generating Docs (#52)
* Allowing New-Extension to be installed with Install-Piecemeal

---

## Piecemeal@0.2.2
* Adding test for [ValidateScript] (#47)
* Updating Piecemeal tests (checking validation order) (#48)
* Get-Extension:  Fixing -ValidateInput logic (#48)
* Get-Extension:  Fixing support for [ValidateScript] (#47)

---

## Piecemeal@0.2.1
* Get-Extension:  Support for -AllValid (#45)
* Get-Extension:  Removing Validation Errors when -ErrorAction is ignore (#43)
* Updating Piecemeal tests: Adding test for Steppable Pipeline (#42)
* Updating Piecemeal Formatting (making .Extends a list) (re #44)
* Get-Extension:  Support for SteppablePipelines (#42).  Fixing .Extends bug (#44)

---

## Piecemeal@0.2
* Adding formatting for extensions (#40)
* Updating Piecemeal tests (account for Regex) (#39)
* Get-Extension:  Regex support for [Cmdlet] attribute (#39)
* Get-Extension:  Adding -FullHelp, -ParameterHelp, -Example(s) (#38)
* Get-Extension:  Adding -Help (#38)

---

## Piecemeal@0.1.10
* Get-Extension:  Adding -ParameterSetName (#36)
* Install-Extension:  Adding -Force to Import-Module in Install Note (#32)

---

## Piecemeal@0.1.9
* Get-Extension: Fixing CouldRun/Run issue with multiple ParameterSets (with other attributes present) (#31)

---

## Piecemeal@0.1.8
* Get-Extension: Fixing CouldRun/Run issue with multiple ParameterSets (#31)
* Install-Piecemeal: Improving Install Message (#32)

---

## Piecemeal@0.1.7
* Get-Extension: Now inherits ParameterSetName (#28)
* Get-Extension: Fixing issue properly displaying Valid Set (#29)

---

## Piecemeal@0.1.6
* Get-Extension now supports all validation attributes (#26/#25)

---

## Piecemeal@0.1.5
* Extensions are now Sortable (#19)
* Get-Extension supports -ExtensionName (#20)
* Get-Extension/Install-Piecemeal renaming parameter -ExtensionNameRegex to -ExtensionPattern (#21)
* Get-Extension:  Adding -ValidateInput / Support for [ValidateScript], [ValidateSet], [ValidatePattern] (#22)

---

## Piecemeal@0.1.4
* Get-Extension:
  * Can now filter extension parameters based off of command (#17)

---

## Piecemeal@0.1.3
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

## Piecemeal@0.1.2
* Get-Extension:
  * Added -NoMandatoryDynamicParameter (#6 / #4)
  * [Parameter] attributes are now copied, so underlying commands are unchanged (#7)

---

## Piecemeal@0.1.1
* Get-Extension:
  * -Parameter not accepts ValueFromPipelineByPropertyName (#2)
  * -CommandName now works (#3)
  * .GetDynamicParameters now supports -NoMandatory (#4)

---

## Piecemeal@0.1
* Initial Release of Piecemeal

---