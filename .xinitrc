#! /bin/sh

xrandr --output eDP-1 --mode 1920x1080
xsetroot -solid black -cursor_name left_ptr
setxkbmap -option '' -option kpdl:dot -layout fr -model pc105
feh --no-fehbg --bg-fill /home/dargor/git/Code.png

xset b off
xset s off
xset r rate 250 30
xset dpms 600 1200 1800
xset -dpms

xset fp default
find /usr/share/fonts/ -name fonts.dir | while read -r f; do
    if ! xset fp+ "${f%fonts.dir}"; then
        echo 1>&2 "Faulty path: $f"
    fi
done
xset fp rehash

[ -x /usr/local/bin/start-pulseaudio ] && /usr/local/bin/start-pulseaudio
[ -x /usr/local/bin/start-picom ] && /usr/local/bin/start-picom
[ -x /usr/bin/numlockx ] && /usr/bin/numlockx
[ -x /usr/bin/xbindkeys ] && /usr/bin/xbindkeys
[ -x /usr/bin/urxvtd ] && /usr/bin/urxvtd -f -o
[ -x /usr/bin/blueman-applet ] && /usr/bin/blueman-applet &
[ -x /usr/bin/redshift-gtk ] && /usr/bin/redshift-gtk -l 48.8566:2.3522 &

exec gpg-agent --daemon ssh-agent i3
