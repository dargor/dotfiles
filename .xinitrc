#! /bin/sh

xsetroot -solid black -cursor_name left_ptr
setxkbmap -option '' -option kpdl:dot -layout fr -model pc105
feh --no-fehbg --bg-fill /home/dargor/git/Necromancer.jpg

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

[ -x /usr/bin/pulseaudio ] && /usr/bin/pulseaudio --start
[ -x /usr/bin/picom ] && nice -n -11 -- chrt -r 4 /usr/bin/picom -b
[ -x /usr/bin/numlockx ] && /usr/bin/numlockx
[ -x /usr/bin/xbindkeys ] && /usr/bin/xbindkeys
[ -x /usr/bin/urxvtd ] && /usr/bin/urxvtd -f -o
[ -x /usr/bin/blueman-applet ] && /usr/bin/blueman-applet &
[ -x /usr/bin/redshift-gtk ] && /usr/bin/redshift-gtk -l 48.8566:2.3522 &
[ -x /usr/bin/pasystray ] && /usr/bin/pasystray &

exec dbus-launch --exit-with-session gpg-agent --daemon ssh-agent i3 --shmlog-size 0
