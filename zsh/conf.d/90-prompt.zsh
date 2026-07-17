if [[ -o interactive && -t 1 ]] && (( $+commands[starship] )); then
  eval "$(starship init zsh)"
fi
