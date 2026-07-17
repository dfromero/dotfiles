if [[ -o interactive && -t 1 ]]; then
  for autosuggestion_plugin in \
    /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh \
    /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh
  do
    if [[ -r "$autosuggestion_plugin" ]]; then
      source "$autosuggestion_plugin"
      break
    fi
  done
  unset autosuggestion_plugin

  for syntax_plugin in \
    /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh \
    /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
  do
    if [[ -r "$syntax_plugin" ]]; then
      source "$syntax_plugin"
      break
    fi
  done
  unset syntax_plugin
fi
