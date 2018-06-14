#!/bin/sh

xsetroot -solid black -cursor_name left_ptr
setxkbmap -option '' -option kpdl:dot -layout fr -model pc105
feh --no-fehbg --bg-fill /home/dargor/git/Code.png

xset b off
xset s off
xset r rate 250 30
xset dpms 600 1200 1800
xset -dpms

xset fp default
for f in /usr/share/fonts/*; do
    case "$f" in
    /usr/share/fonts/encodings|/usr/share/fonts/util)
        ;;
    *)
        xset fp+ "$f"
    esac
done
xset fp rehash

[ -x /usr/bin/xbindkeys ] && /usr/bin/xbindkeys
[ -x /usr/bin/urxvtd ] && /usr/bin/urxvtd -f -o

exec gpg-agent --daemon ssh-agent i3
