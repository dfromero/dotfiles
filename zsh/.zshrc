export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME=""
ZSH_DISABLE_COMPFIX=true
plugins=(git colored-man-pages colorize pip python brew command-not-found)

if [[ -r "$ZSH/oh-my-zsh.sh" ]]; then
  source "$ZSH/oh-my-zsh.sh"
elif [[ -o interactive ]]; then
  autoload -Uz compinit
  compinit
fi

dotfiles_zsh_dir="${${(%):-%N}:A:h}"
for dotfiles_fragment in "$dotfiles_zsh_dir"/conf.d/*.zsh(N); do
  source "$dotfiles_fragment"
done
unset dotfiles_fragment dotfiles_zsh_dir
