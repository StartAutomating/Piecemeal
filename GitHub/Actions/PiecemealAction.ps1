﻿<#
.Synopsis
    GitHub Action for Piecemeal
.Description
    GitHub Action for Piecemeal.  This will:

    * Import Piecemeal
    * Run all *.Piecemeal.ps1 files beneath the workflow directory
    * Run a .PiecemealScript parameter

    Any files changed can be outputted by the script, and those changes can be checked back into the repo.
    Make sure to use the "persistCredentials" option with checkout.
#>

param(
# A PowerShell Script that uses Piecemeal.  
# Any files outputted from the script will be added to the repository.
# If those files have a .Message attached to them, they will be committed with that message.
[string]
$PiecemealScript,

# If set, will not process any files named *.Piecemeal.ps1
[switch]
$SkipPiecemealPS1,

# The name of the module for which types and formats are being generated.
# If not provided, this will be assumed to be the name of the root directory.
[string]
$ModuleName,

# If provided, will commit any remaining changes made to the workspace with this commit message.
# If no commit message is provided, changes will not be committed.
[string]
$CommitMessage,

# The user email associated with a git commit.
[string]
$UserEmail,

# The user name associated with a git commit.
[string]
$UserName
)

"::group::Parameters" | Out-Host
[PSCustomObject]$PSBoundParameters | Format-List | Out-Host
"::endgroup::" | Out-Host


$gitHubEvent = if ($env:GITHUB_EVENT_PATH) {
    [IO.File]::ReadAllText($env:GITHUB_EVENT_PATH) | ConvertFrom-Json
} else { $null }

@"
::group::GitHubEvent
$($gitHubEvent | ConvertTo-Json -Depth 100)
::endgroup::
"@ | Out-Host

$branchName = git rev-parse --abrev-ref HEAD
if (-not $branchName) { 
    return
}

if ($env:GITHUB_ACTION_PATH) {
    $PiecemealModulePath = Join-Path $env:GITHUB_ACTION_PATH 'Piecemeal.psd1'
    if (Test-path $PiecemealModulePath) {
        Import-Module $PiecemealModulePath -Force -PassThru | Out-String
    } else {
        throw "Piecemeal not found"
    }
} elseif (-not (Get-Module Piecemeal)) {    
    throw "Action Path not found"
}

"::notice title=ModuleLoaded::Piecemeal Loaded from Path - $($PiecemealModulePath)" | Out-Host

$anyFilesChanged = $false
$processScriptOutput = { process { 
    $out = $_
    $outItem = Get-Item -Path $out -ErrorAction SilentlyContinue
    $fullName, $shouldCommit = 
        if ($out -is [IO.FileInfo]) {
            $out.FullName, (git status $out.Fullname -s)
        } elseif ($outItem) {
            $outItem.FullName, (git status $outItem.Fullname -s)
        }
    if ($shouldCommit) {
        git add $fullName
        if ($out.Message) {
            git commit -m "$($out.Message)"
        } elseif ($out.CommitMessage) {
            git commit -m "$($out.CommitMessage)"
        }  elseif ($gitHubEvent.head_commit.message) {
            git commit -m "$($gitHubEvent.head_commit.message)"
        }  
        $anyFilesChanged = $true
    }
    $out
} }


if (-not $UserName) { $UserName = $env:GITHUB_ACTOR }
if (-not $UserEmail) { $UserEmail = "$UserName@github.com" }
git config --global user.email $UserEmail
git config --global user.name  $UserName

if (-not $env:GITHUB_WORKSPACE) { throw "No GitHub workspace" }

git pull | Out-Host

$PiecemealScriptStart = [DateTime]::Now
if ($PiecemealScript) {
    Invoke-Expression -Command $PiecemealScript |
        . $processScriptOutput |
        Out-Host
}
$PiecemealScriptTook = [Datetime]::Now - $PiecemealScriptStart

$PiecemealPS1Start = [DateTime]::Now
$PiecemealPS1List  = @()
if (-not $SkipPiecemealPS1) {
    $PiecemealFiles = @(
    Get-ChildItem -Recurse -Path $env:GITHUB_WORKSPACE |
        Where-Object Name -Match '\.Piecemeal\.ps1$')
        
    if ($PiecemealFiles) {
        $PiecemealFiles|        
        ForEach-Object {
            $PiecemealPS1List += $_.FullName.Replace($env:GITHUB_WORKSPACE, '').TrimStart('/')
            $PiecemealPS1Count++
            "::notice title=Running::$($_.Fullname)" | Out-Host
            . $_.FullName |            
                . $processScriptOutput  | 
                Out-Host
        }
    }
}

$PiecemealPS1EndStart = [DateTime]::Now
$PiecemealPS1Took = [Datetime]::Now - $PiecemealPS1Start
if ($CommitMessage -or $anyFilesChanged) {
    if ($CommitMessage) {
        dir $env:GITHUB_WORKSPACE -Recurse |
            ForEach-Object {
                $gitStatusOutput = git status $_.Fullname -s
                if ($gitStatusOutput) {
                    git add $_.Fullname
                }
            }

        git commit -m $ExecutionContext.SessionState.InvokeCommand.ExpandString($CommitMessage)
    }    

    $checkDetached = git symbolic-ref -q HEAD
    if (-not $LASTEXITCODE) {
        "::notice::Pushing Changes" | Out-Host
        git push        
        "Git Push Output: $($gitPushed  | Out-String)"
    } else {
        "::notice::Not pushing changes (on detached head)" | Out-Host
        $LASTEXITCODE = 0
        exit 0
    }
}
