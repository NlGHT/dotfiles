#!/bin/sh

. ~/.profile

[ -f "/usr/bin/prime-offload" ] && \
    /usr/bin/prime-offload &

# Correct the display
~/.bin/AutoRandR

initRun="$XDG_CONFIG_HOME/startup-apps"
[ -f "$initRun" ] && "$initRun"

exec dwm
