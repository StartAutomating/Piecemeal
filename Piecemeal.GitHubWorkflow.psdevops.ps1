#requires -Module PSDevOps
#requires -Module GitPub

Push-Location $PSScriptRoot

New-GitHubWorkflow -Name "Analyze, Test, Tag, and Publish" -On Push, PullRequest, Demand -Job PowerShellStaticAnalysis, TestPowerShellOnLinux, TagReleaseAndPublish, RunHelpOut |
    Set-Content .\.github\workflows\TestAndPublish.yml -Encoding UTF8 -PassThru

New-GitHubWorkflow -Name "Run HelpOut" -On Push  -Job RunHelpOut |
    Set-Content .\.github\workflows\UpdateDocs.yml -Encoding UTF8 -PassThru

Import-BuildStep -ModuleName GitPub

New-GitHubWorkflow -On Issue, Demand -Job RunGitPub -Name "GitPub" -OutputPath .\.github\workflows\GitPub.yml

Pop-Location