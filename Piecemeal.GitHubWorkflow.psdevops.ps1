#requires -Module PSDevOps
#requires -Module GitPub

Push-Location $PSScriptRoot

New-GitHubWorkflow -Name "Analyze, Test, Tag, and Publish" -On Push, PullRequest, Demand -Job PowerShellStaticAnalysis,
    TestPowerShellOnLinux,
    TagReleaseAndPublish,
    RunHelpOut -OutputPath .\.github\workflows\TestAndPublish.yml

Import-BuildStep -ModuleName GitPub

New-GitHubWorkflow -On Issue, Demand -Job RunGitPub -Name "GitPub" -OutputPath .\.github\workflows\GitPub.yml

Pop-Location