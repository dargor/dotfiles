FPATH="/opt/homebrew/share/zsh/site-functions:${FPATH}"
autoload -Uz compinit
compinit

setopt COMPLETE_ALIASES
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_REDUCE_BLANKS
setopt INC_APPEND_HISTORY
setopt PROMPT_SUBST
setopt SHARE_HISTORY

for f in ~/.profile.d/*; do
    source "$f"
done
unset f

if [ -f /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]; then
    source "/opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
    ZSH_AUTOSUGGEST_STRATEGY=(history completion)
fi

if [ -f /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
    source "/opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
    ZSH_HIGHLIGHT_HIGHLIGHTERS+=(brackets)
fi
