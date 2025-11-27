#!/bin/bash

looknfeel_dir="$HOME/.config/hypr/configs/looknfeel"
looknfeel_target_link_path="$HOME/.config/hypr/configs/looknfeel_current.conf"
looknfeel_new_path=""

waybar_styles_dir="$HOME/.config/waybar/styles"
waybar_style_target_link_path="$HOME/.config/waybar/style.css"
waybar_style_new_path=""

case "$(basename "$(readlink $looknfeel_target_link_path)")" in
"minimal.conf")
    looknfeel_new_path="$looknfeel_dir/normal.conf"
    waybar_style_new_path="$waybar_styles_dir/normal.css"
    ;;
"normal.conf")
    looknfeel_new_path="$looknfeel_dir/minimal.conf"
    waybar_style_new_path="$waybar_styles_dir/minimal.css"
    ;;
*)
    looknfeel_new_path="$looknfeel_dir/normal.conf"
    waybar_style_new_path="$waybar_styles_dir/normal.css"
    ;;
esac

ln -sf "$looknfeel_new_path" "$looknfeel_target_link_path"
ln -sf "$waybar_style_new_path" "$waybar_style_target_link_path"

pkill -SIGUSR2 waybar
