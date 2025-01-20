# show help
help:
    @just -l

# bat: update cache
cache:
    bat cache --build

# bat: clear cache
clear:
    bat cache --clear

# download syntax: just
just:
    wget -c https://raw.githubusercontent.com/nk9/just_sublime/refs/heads/main/Syntax/Just.sublime-syntax
