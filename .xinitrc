#!/bin/sh

currentXRule=$(setxkbmap -v 10 print | awk '/rules:/ {print $2}')
[ -z "$currentXRule" ] && currentXRule="xorg"

setxkbmap -v 10 -rules "$currentXRule" -model pc105 -layout us,dk \
        -option "grp:alt_space_toggle" # >> ~/.dwm.log

[ -f "/usr/bin/prime-offload" ] && \
    eval '"/usr/bin/prime-offload"'

# Correct the display
~/.bin/AutoRandR # >> ~/.dwm.log 2>&1

initRun="$XDG_CONFIG_HOME/startup-apps"
[ -f "$initRun" ] && "$initRun" # >> ~/.dwm.log 2>&1

# Debugging
# while true; do
    # # Log stderror to a file
    # dwm >>~/.dwm.log 2>&1
    # # No error logging
    # dwm >/dev/null 2>&1
# done

exec dbus-launch dwm
