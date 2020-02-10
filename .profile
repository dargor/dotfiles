#! /usr/bin/env bash

set -o posix

head -n 7 /etc/issue

export PATH="$HOME/bin:$PATH"

if [ "$TERM" != "xterm-256color" ] && [ "$TERM" != "screen-256color" ] && [ "$TERM" != "rxvt-unicode-256color" ]
then
    export TERM="xterm-color"
fi

export BLOCKSIZE="k"
export QUOTING_STYLE="literal"
export HISTCONTROL="ignorespace:erasedups"
export SCIPY_PIL_IMAGE_VIEWER="feh"
export XCURSOR_THEME="default"
export INPUTRC=~/.inputrc
export GDK_USE_XFT="1"
export LC_COLLATE="C"

if [ -z "${LANG:-}" ]
then
    export LANG="en_US.UTF-8"
fi

if [ -x "/usr/bin/most" ]
then
    export PAGER="/usr/bin/most"
else
    export PAGER="/bin/less"
fi

if [ -x "/usr/bin/vim" ]
then
    export EDITOR="/usr/bin/vim"
else
    export EDITOR="/usr/bin/vi"
fi
export VISUAL="$EDITOR"

if [ -x "/usr/bin/dircolors" ]
then
    eval "$(/usr/bin/dircolors)"
fi

if [ "$UID" -eq "0" ]
then
    umask 022
    PS1='[1;31m\u[0;0m@[1;35m\H[0;0m [1;32m\w[0;0m \D{%F %T} [1;36m\j[0;0m [1;33m$?[0;0m [1;37m$(umask)[0;0m [1;31m${AWS_PROFILE:-}[0;0m\n\$ '
else
    umask 027
    PS1='[1;34m\u[0;0m@[1;35m\H[0;0m [1;32m\w[0;0m \D{%F %T} [1;36m\j[0;0m [1;33m$?[0;0m [1;37m$(umask)[0;0m [1;31m${AWS_PROFILE:-}[0;0m\n\$ '
fi
export PS1="\n$PS1"

function clr
{
    rm -f ./.*~
    rm -f ./*~
}

function rst
{
    if [ "$PWD" = ~ ]
    then
        echo 1>&2 "Bad idea."
    else
        find . -type d -exec chmod 0755 {} \;
        find . -type f -exec chmod 0644 {} \;
    fi
}

alias j="jobs -l"
alias h="history 20"
alias l="ls --color=auto -ap"
alias ll="ls --color=auto -ailp"
alias dir="ls --color=auto -ailp"
alias grep="grep --color=auto"
alias bip="echo "
alias ip="ip --color"
alias ipb="ip --color --brief"
alias nls="jupyter-notebook list"
alias notebook="jupyter-notebook --no-browser"
alias nbconvert="jupyter-nbconvert"
alias lab="jupyter-lab --no-browser"
alias ssh="TERM=xterm-color ssh"
alias maxima="rlwrap maxima"
alias sbcl="rlwrap sbcl"
alias links="links -g"
alias rcli="redis-cli"
alias sc="shellcheck"

for f in ~/.profile.d/*; do
    . "$f"
done
