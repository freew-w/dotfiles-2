#!/bin/bash
filename="screenshot_$(date +%Y%m%d_%H%M%S).png"
file_path="$HOME/Pictures/$filename"
mkdir -p "$(dirname "$file_path")"
grim -g "$(slurp)" "$file_path" && notify-send "Screenshot" "Saved to $file_path"
