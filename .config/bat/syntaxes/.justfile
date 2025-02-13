# show help
help:
    @just -l

# fetch all syntaxes
fetch:
    just | grep 'download syntax:' | awk '{print $1}' | xargs just

# bat: update cache
cache:
    bat cache --build

# bat: clear cache
clear:
    bat cache --clear

# download syntax: just
just:
    wget -c https://raw.githubusercontent.com/nk9/just_sublime/refs/heads/main/Syntax/Just.sublime-syntax

# download syntax: tmux
tmux:
    wget -c https://raw.githubusercontent.com/gerardroche/sublime-tmux/refs/heads/master/Tmux.sublime-syntax
