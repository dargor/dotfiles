# show help
help:
    @just -l

# fetch all syntaxes
[group('fetch')]
fetch:
    @just -l | grep 'download syntax:' | awk '{print $1}' | xargs just

# clean all files
[group('fetch')]
clean:
    rm -vf *.sublime-syntax

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

# download syntax: systemd
[group('syntax')]
systemd:
    wget -c https://gist.githubusercontent.com/thendrix/2330cf22ba6cae6a0c574fa22a7809fc/raw/24040eebccc596a1932be256ccb34d2b66926fb6/Systemd.sublime-syntax
