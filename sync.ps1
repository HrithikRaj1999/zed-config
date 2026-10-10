# Commits local Zed config changes, pulls changes from other PCs, then pushes.
param([string]$Message = "Sync Zed config from $env:COMPUTERNAME")

$ErrorActionPreference = 'Stop'

function Invoke-Git {
    git -c core.safecrlf=false @args
    if ($LASTEXITCODE -ne 0) { throw "git $($args -join ' ') failed" }
}

Push-Location $PSScriptRoot
try {
    Invoke-Git add -A

    git diff --cached --quiet
    if ($LASTEXITCODE -ne 0) {
        # Block anything that looks like a secret, since this repo is public.
        $secretPattern = '"[^"]*(api_key|apikey|secret|password|token)"\s*:|sk-[A-Za-z0-9_-]{20,}|gh[pousr]_[A-Za-z0-9]{30,}|github_pat_'
        $leaks = git diff --cached -U0 -- . ':!sync.ps1' |
            Where-Object { $_ -match '^\+[^+]' -and $_ -match $secretPattern }
        if ($leaks) {
            Invoke-Git reset -q
            $leaks | ForEach-Object { Write-Host "  $_" -ForegroundColor Red }
            throw 'Possible secret found in staged changes. Nothing was committed or pushed.'
        }
        Invoke-Git commit -q -m $Message
        Write-Host 'Committed local changes.'
    }

    Invoke-Git pull --rebase -q
    Invoke-Git push -q
    Write-Host 'Zed config is in sync.' -ForegroundColor Green
}
finally {
    Pop-Location
}
