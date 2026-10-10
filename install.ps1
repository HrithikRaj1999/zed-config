# One-time setup on a new Windows PC: turns %APPDATA%\Zed into a clone of this repo.
# Wrapped in a script block so it is safe to run via 'irm ... | iex'.
& {
    $ErrorActionPreference = 'Stop'

    $repo = 'https://github.com/HrithikRaj1999/zed-config.git'
    $zed = Join-Path $env:APPDATA 'Zed'

    function Invoke-Git {
        git @args
        if ($LASTEXITCODE -ne 0) { throw "git $($args -join ' ') failed" }
    }

    if (Test-Path (Join-Path $zed '.git')) {
        Write-Host "Already set up: $zed"
        return
    }

    if (Test-Path $zed) {
        $backup = "$zed-backup-$(Get-Date -Format yyyyMMdd-HHmmss)"
        Copy-Item $zed $backup -Recurse
        Write-Host "Backed up existing config to $backup"
    } else {
        New-Item -ItemType Directory $zed | Out-Null
    }

    Invoke-Git -C $zed init -q -b main
    Invoke-Git -C $zed remote add origin $repo
    Invoke-Git -C $zed config user.name HrithikRaj1999
    Invoke-Git -C $zed config user.email studyraj81@gmail.com
    Invoke-Git -C $zed fetch -q origin
    # The repo wins over whatever config this PC had.
    Invoke-Git -C $zed reset -q --hard origin/main
    Invoke-Git -C $zed branch -q --set-upstream-to=origin/main main

    Write-Host "Done. Zed config at $zed now tracks $repo" -ForegroundColor Green
    Write-Host 'Restart Zed to pick up the theme, fonts and extensions.'
}
