# show help
help:
    @just -l

# fetch all syntaxes
[group('fetch')]
fetch:
    @just -l | grep 'download syntax:' | awk '{print $1}' | xargs just

# bat: update cache
[group('cache')]
cache:
    bat cache --build

# bat: clear cache
[group('cache')]
clear:
    bat cache --clear

# download syntax: just
[group('syntax')]
just:
    wget -c https://raw.githubusercontent.com/nk9/just_sublime/refs/heads/main/Syntax/Just.sublime-syntax

# download syntax: tmux
[group('syntax')]
tmux:
    wget -c https://raw.githubusercontent.com/gerardroche/sublime-tmux/refs/heads/master/Tmux.sublime-syntax

# download syntax: kdl
[group('syntax')]
kdl:
    wget -c https://raw.githubusercontent.com/eugenesvk/sublime-KDL/refs/heads/main/KDL1.sublime-syntax
