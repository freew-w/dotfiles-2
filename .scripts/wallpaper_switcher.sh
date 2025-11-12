#!/bin/bash

wallpaper_dir="$HOME/.wallpapers/"

wallpaper_filename="$(
    for file in $wallpaper_dir*.{jpg,jpeg,png,gif}; do
        [[ ! -f "$file" ]] && continue
        printf "$(basename "$file")\0icon\x1fthumbnail://$file\n"
    done | rofi -dmenu \
        -theme-str "element-icon { size: 140px; }" \
        -theme-str "listview { lines: 3; }"
    )"

# Exit with exit code 1 if no wallpaper is selected
[[ -z "$wallpaper_filename" ]] && exit 1

wallpaper_path="$wallpaper_dir$wallpaper_filename"

# Change wallpaper
matugen image "$wallpaper_path"

# Symlinks
ln -sf "$wallpaper_path" "$HOME/.current_wallpaper"
