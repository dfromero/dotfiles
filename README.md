# dotfiles

Personal Zsh and Starship configuration for macOS. Tracked files stay portable; machine- and work-specific settings live outside this repository.

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

## Rollback

Remove the four managed symlinks and restore matching files from the newest `~/.dotfiles-backups/YYYYMMDD-HHMMSS/` directory. The initial migration archive can also be restored:

```sh
tar -xzf /private/tmp/dotfiles-pre-migration-20260717.tgz -C "$HOME"
```

Inspect the archive before restoring if shell files changed after migration.
