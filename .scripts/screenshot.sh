#!/bin/bash

filename="screenshot_$(date +%Y%m%d_%H%M%S).png"
file_path="$HOME/Pictures/$filename"
mkdir -p "$(dirname "$file_path")"
if grim -g "$(slurp)" "$file_path"; then
    response="$(notify-send --action="open=Open" "Screenshot" "Saved to $file_path")"
    if [[ "$response" == "open" ]]; then
        thunar "$(dirname "$file_path")"
    fi
fi
