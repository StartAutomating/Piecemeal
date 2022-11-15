#requires -Module PSDevOps
#requires -Module Piecemeal
Import-BuildStep -ModuleName Piecemeal
New-GitHubAction -Name "UsePiecemeal" -Description @'
Add extensibility to any PowerShell module with Piecemeal
'@ -Action PiecemealAction -Icon terminal -OutputPath .\action.yml