#!/bin/bash

nitrogen --restore &
polkit-gnome-authentication-agent-1 &
xset s off &
xset -dpms &
xset led on &
numlockx on &
xinput --set-prop 12 'libinput Accel Profile Enabled' 0, 1
