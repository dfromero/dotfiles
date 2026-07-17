_load_cursor_agent_integration() {
  [[ "$CURSOR_AGENT_INTEGRATION_LOADED" == 1 ]] && return 0
  (( $+commands[agent] )) || return 1
  unfunction agent 2>/dev/null || true
  export CURSOR_RECORD_SESSION="${CURSOR_RECORD_SESSION:-1}"
  eval "$(command agent shell-integration zsh)"
  export CURSOR_AGENT_INTEGRATION_LOADED=1
}

agent() {
  _load_cursor_agent_integration || return $?
  agent "$@"
}

_load_nvm() {
  [[ "$_NVM_LAZY_LOADED" == 1 ]] && return 0
  [[ -s "$NVM_DIR/nvm.sh" ]] || return 1
  typeset -g _NVM_LAZY_LOADED=1
  if ! source "$NVM_DIR/nvm.sh" --no-use; then
    typeset -g _NVM_LAZY_LOADED=0
    return 1
  fi
  unfunction node npm npx pnpm yarn corepack 2>/dev/null || true
}

nvm() {
  _load_nvm || return $?
  nvm "$@"
}

for nvm_command in node npm npx pnpm yarn corepack; do
  eval "${nvm_command}() { _load_nvm || return \$?; load-nvmrc; command ${nvm_command} \"\$@\"; }"
done
unset nvm_command

if [[ -d "$PYENV_ROOT/bin" ]] && (( $+commands[pyenv] )); then
  eval "$(pyenv init - zsh)"
fi

if [[ -d "$RBENV_ROOT/bin" ]] && (( $+commands[rbenv] )); then
  eval "$(rbenv init - zsh)"
fi

_load_conda() {
  [[ "$CONDA_LOADED" == 1 ]] && return 0
  if [[ -x /opt/miniconda3/bin/conda ]]; then
    local conda_setup
    conda_setup="$(/opt/miniconda3/bin/conda shell.zsh hook 2>/dev/null)"
    if [[ $? -eq 0 ]]; then
      eval "$conda_setup"
    elif [[ -f /opt/miniconda3/etc/profile.d/conda.sh ]]; then
      source /opt/miniconda3/etc/profile.d/conda.sh
    else
      path=(/opt/miniconda3/bin "${path[@]}")
    fi
    export CONDA_LOADED=1
  else
    return 1
  fi
}

conda() {
  _load_conda || return $?
  conda "$@"
}

[[ -s "$BUN_INSTALL/_bun" ]] && source "$BUN_INSTALL/_bun"

java_8_home="$(/usr/libexec/java_home -v 1.8 2>/dev/null)"
if [[ -n "$java_8_home" ]]; then
  export JAVA_HOME="$java_8_home"
  path=("$JAVA_HOME/bin" "${path[@]}")
fi
unset java_8_home
