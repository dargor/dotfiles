FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
autoload -Uz compinit
compinit

setopt COMPLETE_ALIASES
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_REDUCE_BLANKS
setopt PROMPT_SUBST

for f in ~/.profile.d/*; do
    . "$f"
done
unset f
