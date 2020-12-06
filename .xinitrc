#!/bin/sh

. ~/.profile

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
