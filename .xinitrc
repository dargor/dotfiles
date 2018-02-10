#!/bin/sh

xsetroot -solid black -cursor_name left_ptr
setxkbmap -option '' -option kpdl:dot -layout fr -model pc105
feh --no-fehbg --bg-fill /home/dargor/git/Code.png

xset b off
xset s off
xset r rate 250 30
xset dpms 600 1200 1800
xset -dpms

[ -x /usr/bin/xbindkeys ] && /usr/bin/xbindkeys
[ -x /usr/bin/gpg-agent ] && eval "$(/usr/bin/gpg-agent --daemon)"

exec ssh-agent i3
