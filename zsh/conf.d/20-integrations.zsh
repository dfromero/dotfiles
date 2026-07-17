[[ -r "$HOME/.openclaw/completions/openclaw.zsh" ]] && source "$HOME/.openclaw/completions/openclaw.zsh"

if [[ "$TERM_PROGRAM" == kiro ]] && (( $+commands[kiro] )); then
  source "$(kiro --locate-shell-integration-path zsh)"
fi

if [[ -o interactive && -t 1 ]] && (( $+commands[codex] )); then
  eval "$(codex completion zsh 2>/dev/null)"
fi

if [[ -o interactive && -t 1 ]] && (( $+commands[carapace] )); then
  export CARAPACE_BRIDGES='zsh,fish,bash,inshellisense'
  zstyle ':completion:*' format $'\e[2;37mCompleting %d\e[m'
  source <(carapace _carapace zsh)
fi

if [[ -o interactive && -t 1 ]] && (( $+commands[fzf] )); then
  eval "$(fzf --zsh)"
fi

if [[ -o interactive && -t 1 ]] && (( $+commands[zoxide] )); then
  eval "$(zoxide init zsh)"
fi
