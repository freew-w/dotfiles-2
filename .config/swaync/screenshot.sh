#!/bin/bash
filename=screenshot_$(date +%Y%m%d_%H%M%S).png
grim -g "$(slurp)" "$HOME/Pictures/$filename" && notify-send "Screenshot" "$filename saved to ~/Pictures/"
