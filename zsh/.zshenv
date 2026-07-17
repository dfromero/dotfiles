typeset -gU path PATH

export NPM_CONFIG_USERCONFIG="$HOME/.npm-global/.npmrc"
export NVM_DIR="$HOME/.nvm"
export PNPM_HOME="$HOME/Library/pnpm"
export PYENV_ROOT="$HOME/.pyenv"
export RBENV_ROOT="$HOME/.rbenv"
export BUN_INSTALL="$HOME/.bun"
export FLYCTL_INSTALL="$HOME/.fly"
export STARSHIP_CONFIG="$HOME/.config/starship/starship.toml"
export CAVEMAN_DEFAULT_MODE=ultra
export EDITOR=nvim
export VISUAL=nvim

_dotfiles_path_prepend() {
  [[ -d "$1" ]] && path=("$1" "${path[@]}")
}

_dotfiles_path_append() {
  [[ -d "$1" ]] && path+=("$1")
}

_dotfiles_path_prepend "$HOME/.local/bin"
_dotfiles_path_prepend "$HOME/bin"
_dotfiles_path_append "$HOME/development/flutter/bin"
_dotfiles_path_append "$HOME/.opencode/bin"
_dotfiles_path_append "$HOME/scripts"
_dotfiles_path_append "$HOME/.cargo/bin"
_dotfiles_path_append "$PNPM_HOME"
_dotfiles_path_append "$BUN_INSTALL/bin"
_dotfiles_path_append "$PYENV_ROOT/bin"
_dotfiles_path_append "$RBENV_ROOT/bin"
_dotfiles_path_append "$FLYCTL_INSTALL/bin"
_dotfiles_path_append "$HOME/.antigravity/antigravity/bin"

[[ -r "$HOME/.cargo/env" ]] && source "$HOME/.cargo/env"

unfunction _dotfiles_path_prepend _dotfiles_path_append
