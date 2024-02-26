for f in ~/.profile.d/*; do
    . "$f"
done
unset f
