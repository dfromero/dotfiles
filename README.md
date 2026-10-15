# dotfiles

Personal Zsh, Starship, and WezTerm configuration for macOS. Tracked files stay portable; machine- and work-specific settings live outside this repository.

## Install

Clone this repository to `~/.dotfiles`, then run:

```sh
~/.dotfiles/bin/bootstrap
```

Bootstrap only creates explicit symlinks and validates the result. It does not install Homebrew, Oh My Zsh, plugins, or packages. Existing target files move to a timestamped directory under `~/.dotfiles-backups/` before linking.

Run the read-only checks at any time:

```sh
~/.dotfiles/bin/check
```

## Local configuration

Put machine- or employer-specific shell configuration in `~/.config/zsh/local.zsh`. Start from [`zsh/local.example.zsh`](zsh/local.example.zsh). This file is sourced when present and is never tracked.

Keep secrets in `~/.zsh_secrets`, which is also sourced when present and must remain private.

Optional commands are guarded. Homebrew is supported in both Apple Silicon (`/opt/homebrew`) and Intel (`/usr/local`) locations.

## Managed links

- `~/.zshenv` → `~/.dotfiles/zsh/.zshenv`
- `~/.zprofile` → `~/.dotfiles/zsh/.zprofile`
- `~/.zshrc` → `~/.dotfiles/zsh/.zshrc`
- `~/.config/starship/starship.toml` → `~/.dotfiles/starship/starship.toml`

## WezTerm

[`wezterm/`](wezterm/) contains a snapshot of `~/.config/wezterm/`, including the Lua modules, custom colors, key bindings, launch menu, and background images. It preserves the local customizations to [KevinSilvester/wezterm-config](https://github.com/KevinSilvester/wezterm-config); the upstream MIT license is included in [`wezterm/LICENSE`](wezterm/LICENSE).

Bootstrap manages only the four links above. Install [WezTerm](https://formulae.brew.sh/cask/wezterm) and [JetBrainsMono Nerd Font](https://formulae.brew.sh/cask/font-jetbrains-mono-nerd-font) separately:

```sh
brew install --cask wezterm font-jetbrains-mono-nerd-font
```

With this repository cloned to `~/.dotfiles`, run the following to back up any existing WezTerm configuration, copy the complete configuration, and validate it without opening a window:

```sh
(
  set -eu
  mkdir -p "$HOME/.config" "$HOME/.dotfiles-backups"
  if [ -e "$HOME/.config/wezterm" ] || [ -L "$HOME/.config/wezterm" ]; then
    backup_dir="$(mktemp -d "$HOME/.dotfiles-backups/wezterm.XXXXXX")"
    mv "$HOME/.config/wezterm" "$backup_dir/wezterm"
    printf 'Previous configuration saved to %s/wezterm\n' "$backup_dir"
  fi
  cp -R "$HOME/.dotfiles/wezterm" "$HOME/.config/wezterm"
  wezterm --config-file "$HOME/.config/wezterm/wezterm.lua" show-keys
)
```

Open WezTerm after validation succeeds. Copy the entire directory: the entry point depends on the other Lua modules and background images. If `WEZTERM_CONFIG_FILE` is set, point it to `~/.config/wezterm/wezterm.lua`.

The macOS default shell is `zsh -l`. Customize fonts in [`wezterm/config/fonts.lua`](wezterm/config/fonts.lua), appearance in [`wezterm/config/appearance.lua`](wezterm/config/appearance.lua), and shortcuts in [`wezterm/config/bindings.lua`](wezterm/config/bindings.lua). Validate changes with WezTerm itself; these files use Lua 5.4 syntax.

Common macOS shortcuts (`Cmd` is the Command key):

| Shortcut | Action |
| --- | --- |
| `Cmd+T` | New tab |
| `Cmd+[` / `Cmd+]` | Previous / next tab |
| `Cmd+\` / `Cmd+Ctrl+\` | Split top/bottom / left/right |
| `Cmd+Enter` | Toggle pane zoom |
| `Cmd+Ctrl+H/J/K/L` | Focus left/down/up/right pane |
| `Cmd+B` | Toggle background images |
| `Cmd+,` / `Cmd+.` | Previous / next background |
| `Cmd+/` | Random background |
| `F2` | Command palette |

The installed directory is a copy. After editing it, copy the changed files back into `~/.dotfiles/wezterm/` before committing future updates. To roll back, move the installed directory aside and restore `wezterm/` from the backup path printed above.

## Rollback

Remove the four managed symlinks and restore matching files from the newest `~/.dotfiles-backups/YYYYMMDD-HHMMSS/` directory. The initial migration archive can also be restored:

```sh
tar -xzf /private/tmp/dotfiles-pre-migration-20260717.tgz -C "$HOME"
```

Inspect the archive before restoring if shell files changed after migration.
