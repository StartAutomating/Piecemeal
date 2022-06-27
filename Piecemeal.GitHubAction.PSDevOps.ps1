#requires -Module PSDevOps
#requires -Module Piecemeal
Import-BuildStep -ModuleName Piecemeal
New-GitHubAction -Name "UsePiecemeal" -Description 'Add extensibility to any PowerShell module with Piecemeal' -Action PiecemealAction -Icon terminal  -ActionOutput ([Ordered]@{
    PiecemealScriptRuntime = [Ordered]@{
        description = "The time it took the .PiecemealScript parameter to run"
        value = '${{steps.PiecemealAction.outputs.PiecemealScriptRuntime}}'
    }
    PiecemealPS1Runtime = [Ordered]@{
        description = "The time it took all .Piecemeal.ps1 files to run"
        value = '${{steps.PiecemealAction.outputs.PiecemealPS1Runtime}}'
    }
    PiecemealPS1Files = [Ordered]@{
        description = "The .Piecemeal.ps1 files that were run (separated by semicolons)"
        value = '${{steps.PiecemealAction.outputs.PiecemealPS1Files}}'
    }
    PiecemealPS1Count = [Ordered]@{
        description = "The number of .Piecemeal.ps1 files that were run"
        value = '${{steps.PiecemealAction.outputs.PiecemealPS1Count}}'
    }
}) |
    Set-Content .\action.yml -Encoding UTF8 -PassThru
