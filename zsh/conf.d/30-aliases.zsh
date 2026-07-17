(( $+commands[nvim] )) && alias vim=nvim
alias fzfbat='fzf --preview="bat --theme=gruvbox-dark --color=always {}"'
alias fzfnvim='nvim $(fzf --preview="bat --theme=gruvbox-dark --color=always {}")'

if (( $+commands[eza] )); then
  alias ls='eza --no-filesize --long --color=always --icons=always --no-user'
else
  alias ls='ls -G'
fi

export FZF_DEFAULT_COMMAND='fd --hidden --strip-cwd-prefix --exclude .git'
export FZF_DEFAULT_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_COMMAND='fd --type=d --hidden --strip-cwd-prefix --exclude .git'
export FZF_CTRL_T_OPTS="--walker-skip .git,node_modules,target --preview 'bat -n --color=always {} --line-range :500 {}' --bind 'ctrl-/:change-preview-window(down|hidden|)'"
export FZF_DEFAULT_OPTS='--height 50% --layout=default --border --color=hl:#2dd4bf'
export FZF_ALT_C_OPTS="--preview 'eza --icons=always --tree --color=always {} | head -200'"
export FZF_TMUX_OPTS=' -p90%,70% '
