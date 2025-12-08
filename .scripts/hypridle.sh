#!/bin/bash

if [[ -n "$(pidof hypridle)" ]]; then
    pkill -x hypridle
    notify-send "󰒳 Hypridle disabled"
else
    hypridle &
    notify-send "󰒲 Hypridle enabled"
fi
