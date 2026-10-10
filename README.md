# zed-config

My Zed settings, keymap, themes and agent rules, shared across all my PCs.

The Zed config folder on each PC is a git clone of this repo, so Zed reads the files straight from the working tree.

| OS | Config folder |
|----|---------------|
| Windows | `%APPDATA%\Zed` |
| macOS / Linux | `~/.config/zed` |

## Set up a new PC

Windows (PowerShell):

```powershell
irm https://raw.githubusercontent.com/HrithikRaj1999/zed-config/main/install.ps1 | iex
```

The script backs up any existing config to `%APPDATA%\Zed-backup-<timestamp>`, then replaces it with this repo.

macOS / Linux:

```sh
mv ~/.config/zed ~/.config/zed-backup 2>/dev/null
git clone https://github.com/HrithikRaj1999/zed-config.git ~/.config/zed
```

Restart Zed afterwards. Extensions listed in `auto_install_extensions` install on first launch.

## Keep PCs in sync

Run after changing settings on any PC, and before starting work on another one:

```powershell
& "$env:APPDATA\Zed\sync.ps1"
```

It commits local changes, pulls changes from the other PCs and pushes. It refuses to commit anything that looks like an API key or token, because this repo is public.

On macOS / Linux:

```sh
cd ~/.config/zed && git add -A && git commit -m "Sync Zed config" ; git pull --rebase && git push
```

## Fonts

`settings.json` uses **Cascadia Mono**. It ships with Windows 11. On other systems, install it from [microsoft/cascadia-code](https://github.com/microsoft/cascadia-code/releases) or Zed falls back to its default font.

## What gets synced

Only the files allowed in `.gitignore`: `settings.json`, `keymap.json`, `tasks.json`, `debug.json`, `AGENTS.md`, `themes/` and `snippets/`. Anything else Zed writes to the config folder stays local.
