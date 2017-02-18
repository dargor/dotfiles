#!/bin/sh

set -o posix

export PATH="/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:/usr/games"

if [ "$TERM" != "xterm-256color" ]
then
	export TERM="xterm-color"
fi

export BLOCKSIZE="k"
export HISTCONTROL="ignorespace:erasedups"
export INPUTRC="~/.inputrc"
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
	PS1='[1;31m\u[0;0m@[1;35m\H[0;0m [1;32m\w[0;0m \D{%F %T} [1;36m\j[0;0m [1;33m$?[0;0m\n\$ '
else
	umask 027
	PS1='[1;34m\u[0;0m@[1;35m\H[0;0m [1;32m\w[0;0m \D{%F %T} [1;36m\j[0;0m [1;33m$?[0;0m\n\$ '
fi
export PS1="\n$PS1"

function clr
{
	rm -f .*~
	rm -f *~
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
alias ll="ls --color=auto -ailp"
alias dir="ls --color=auto -ailp"
alias grep="grep --color=auto"

# XXX ce qui suit doit rester en dernier

cd ~/.profile.d/
for f in *
do
	if [ "$f" != '*' ]
	then
		. ./"$f"
	fi
done
cd

LAST_COMMAND=""

function reset_term_title
{
	if [ -z "`jobs -p`" ]
	then
		LAST_COMMAND=""
	fi
	echo -ne "\033]0;Terminal\007"
}

function change_term_title
{
	if [ "$BASH_COMMAND" != "$PROMPT_COMMAND" ]
	then
		if [ "$BASH_COMMAND" = "fg" ]
		then
			echo -ne "\033]0;$LAST_COMMAND\007"
		else
			if [ -z "$LAST_COMMAND" ]
			then
				LAST_COMMAND="$BASH_COMMAND"
			fi
			echo -ne "\033]0;$BASH_COMMAND\007"
		fi
	fi
}

if [ -n "$XTERM_LOCALE" ]
then
	export PROMPT_COMMAND=reset_term_title
	trap change_term_title DEBUG
fi
