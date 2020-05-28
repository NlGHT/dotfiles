#!/bin/sh

############## LightDM Startup Script ############## 

# I make it executable (chmod +x .XStartupScript) and symlink this to /usr/share o that it can be used by any user

# Configure resolution (Intel)
xrandr --output eDP-1 --primary --mode 1920x1080 --pos 0x0 --rotate normal --output DP-1-1 --off --output HDMI-1-1 --off --output DP-1-2 --off --output HDMI-1-2 --off

# xrandr > bruh.txt # For any debugging
sleep 0.01s # Apparently bash doesn't wait around for xrandr to do its business

# Configure resolution (NVIDIA)
xrandr | grep 'eDP-1-1 connected' &&
	xrandr --output eDP-1 --off --output eDP-1-1 --primary --mode 1920x1080 --pos 0x0 --rotate normal --output DP-1-1 --off --output HDMI-1-1 --off --output DP-1-2 --off --output HDMI-1-2 --off

# xrandr > bruh2.txt # For any debugging
sleep 0.01s # Apparently bash doesn't wait around for xrandr to do its business

# Configure 2nd monitor if it's connected
xrandr | grep 'HDMI-1-1 connected' &&
    xrandr --output eDP-1-1 --mode 1920x1080 --pos 0x0 --rotate normal --output HDMI-1-1 --primary --auto --left-of eDP-1-1

sleep 0.01s # Apparently bash doesn't wait around for xrandr to do its business

# Configure if there is a third monitor (which I don't use but yeah)
xrandr | grep 'HDMI-1-2 connected' &&
    xrandr --output eDP-1-1 --mode 1920x1080 --pos 0x0 --rotate normal --output HDMI-1-2 --primary --auto --left-of eDP-1-1

sleep 0.01s # Apparently bash doesn't wait around for xrandr to do its business
