#!/bin/bash
current="$(tuned-adm active | cut -d " " -f4)"
new=""

case "$current" in
"balanced")
    new="laptop-battery-powersave"
    tuned-adm profile "$new"
    ;;
"laptop-battery-powersave")
    new="latency-performance"
    tuned-adm profile "$new"
    ;;
"latency-performance")
    new="balanced"
    tuned-adm profile "$new"
    ;;
*)
    new="balanced"
    tuned-adm profile "$new"
    ;;
esac

notify-send "Power Profile" "Switched to $new"
