autoload -U add-zsh-hook

load-nvmrc() {
  local directory="$PWD" nvmrc_path=''
  while [[ "$directory" != / ]]; do
    if [[ -f "$directory/.nvmrc" ]]; then
      nvmrc_path="$directory/.nvmrc"
      break
    fi
    directory="${directory:h}"
  done

  [[ -n "$nvmrc_path" ]] || return 0
  _load_nvm || return 0

  local node_version
  node_version="$(<"$nvmrc_path")"
  if [[ "$(nvm version "$node_version")" == N/A ]]; then
    nvm install "$node_version"
  fi
  nvm use "$node_version" >/dev/null 2>&1
}

add-zsh-hook chpwd load-nvmrc

z() {
  local directory
  directory="$(zoxide query --list --score | fzf --height 40% --layout reverse --info inline --nth 2.. --tac --no-sort --query "$*" --bind 'enter:become:echo {2..}')" || return
  cd "$directory" || return
}

opencode() {
  env -u NPM_CONFIG_USERCONFIG NPM_CONFIG_REGISTRY='https://registry.npmjs.org/' command opencode "$@"
}

_fabric_question_alias_accept_line() {
  if [[ "$BUFFER" == '??' || "$BUFFER" == '?? '* ]]; then
    BUFFER="fabric${BUFFER[3,-1]}"
  fi
  zle .accept-line
}

if [[ -o interactive && -t 1 ]]; then
  zle -N accept-line _fabric_question_alias_accept_line
fi

y() {
  local temporary_file current_directory
  temporary_file="$(mktemp -t 'yazi-cwd.XXXXXX')" || return
  command yazi "$@" --cwd-file="$temporary_file"
  IFS= read -r -d '' current_directory < "$temporary_file"
  [[ "$current_directory" != "$PWD" && -d "$current_directory" ]] && builtin cd -- "$current_directory"
  command rm -f -- "$temporary_file"
}
