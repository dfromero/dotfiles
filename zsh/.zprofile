typeset -gU path PATH

if [[ -x /opt/homebrew/bin/brew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ -x /usr/local/bin/brew ]]; then
  eval "$(/usr/local/bin/brew shellenv)"
fi

[[ -d /opt/local/bin ]] && path+=(/opt/local/bin)
[[ -d /opt/local/sbin ]] && path+=(/opt/local/sbin)
[[ -d /Applications/Obsidian.app/Contents/MacOS ]] && path+=(/Applications/Obsidian.app/Contents/MacOS)

export CLICOLOR=1
