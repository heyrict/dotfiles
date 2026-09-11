# !/bin/env bash
# Changes theme to 0/dark or 1/light
# Usage: ./theme.sh dark

GTK_THEME_DARK=Arc-Dark
GTK_THEME_LIGHT=Arc
QT_THEME_DARK=KvArcDark
QT_THEME_LIGHT=KvArc
ALACRITTY_THEME_DARK=gruvbox_dark.toml
ALACRITTY_THEME_LIGHT=gruvbox_light.toml
SWAY_THEME_DARK=gruvbox-dark.conf
SWAY_THEME_LIGHT=catppuccin-latte.conf
#WALLPAPER_DARK="wallpaperaccess/ai-generated/9070149.jpg"
#WALLPAPER_LIGHT="wallpaperaccess/light-green/397977.jpg"
ZATHURA_THEME_LIGHT=zathura-gruvbox/zathura-gruvbox-light
ZATHURA_THEME_DARK=zathura-gruvbox/zathura-gruvbox-dark
WOFI_THEME_DARK=quantumfate/src/macchiato/style.css
WOFI_THEME_LIGHT=quantumfate/src/latte/style.css
ZELLIJ_THEME_DARK=catppuccin-macchiato
ZELLIJ_THEME_LIGHT=catppuccin-latte
WAYBAR_THEME_DARK=catppuccin/macchiato.css
WAYBAR_THEME_LIGHT=catppuccin/latte.css
HYPRLAND_THEME_DARK=catppuccin/mocha.conf
HYPRLAND_THEME_LIGHT=catppuccin/latte.conf

BTM_THEME_DARK=gruvbox
BTM_THEME_LIGHT=default
BAT_THEME_DARK="Catppuccin Mocha"
BAT_THEME_LIGHT="Catppuccin Latte"
DELTA_THEME_DARK=catppuccin-mocha
DELTA_THEME_LIGHT=catppuccin-latte
DELTA_SYNTAX_THEME_DARK=gruvbox-dark
DELTA_SYNTAX_THEME_LIGHT=gruvbox-light
FZF_THEME_DARK=catppuccin-fzf-frappe
FZF_THEME_LIGHT=catppuccin-fzf-latte

if ! command -v gsettings > /dev/null; then
    exit 1; # Gsettings not found
fi

case "$1" in
    1|light) is_light=1
    ;;
    0|dark) is_light=0
    ;;
    *) # Switch theme
        current=$(gsettings get org.gnome.desktop.interface color-scheme)
        if [ ${current//\'/} = "prefer-light" ]; then
            is_light=0
        else
            is_light=1
        fi
    ;;
esac

if [ $is_light = 1 ]; then
    gsettings set org.gnome.desktop.interface color-scheme prefer-light
    gtk_theme=$GTK_THEME_LIGHT
    qt_theme=$QT_THEME_LIGHT
    alacritty_theme=$ALACRITTY_THEME_LIGHT
    sway_theme=$SWAY_THEME_LIGHT
    #wallpaper=$WALLPAPER_LIGHT
    zathura_theme=$ZATHURA_THEME_LIGHT
    wofi_theme=$WOFI_THEME_LIGHT
    zellij_theme=$ZELLIJ_THEME_LIGHT
    waybar_theme=${WAYBAR_THEME_LIGHT//\//\\\/}
    hyprland_theme=${HYPRLAND_THEME_LIGHT//\//\\\/}

    btm_theme=$BTM_THEME_LIGHT
    bat_theme=$BAT_THEME_LIGHT
    delta_theme=$DELTA_THEME_LIGHT
    delta_syntax_theme=$DELTA_SYNTAX_THEME_LIGHT
    fzf_theme=$FZF_THEME_LIGHT
else
    gsettings set org.gnome.desktop.interface color-scheme prefer-dark
    gtk_theme=$GTK_THEME_DARK
    qt_theme=$QT_THEME_DARK
    alacritty_theme=$ALACRITTY_THEME_DARK
    sway_theme=$SWAY_THEME_DARK
    #wallpaper=$WALLPAPER_DARK
    zathura_theme=$ZATHURA_THEME_DARK
    wofi_theme=$WOFI_THEME_DARK
    zellij_theme=$ZELLIJ_THEME_DARK
    waybar_theme=${WAYBAR_THEME_DARK//\//\\\/}
    hyprland_theme=${HYPRLAND_THEME_DARK//\//\\\/}

    btm_theme=$BTM_THEME_DARK
    bat_theme=$BAT_THEME_DARK
    delta_theme=$DELTA_THEME_DARK
    delta_syntax_theme=$DELTA_SYNTAX_THEME_DARK
    fzf_theme=$FZF_THEME_DARK
fi

# GTK Theme {{{1
gsettings set org.gnome.desktop.interface gtk-theme ${gtk_theme}
gsettings set org.gnome.desktop.interface icon-theme ${gtk_theme}
gtk_3_settings="$HOME/.config/gtk-3.0/settings.ini"
gtk_4_settings="$HOME/.config/gtk-4.0/settings.ini"
if [ -f "${gtk_3_settings}" ];
then
    sed -e "/gtk-application-prefer-dark-theme/s/=.*/=false/" \
        -e "/gtk-theme-name/s/=.*/=${gtk_theme}/" \
        -i "${gtk_3_settings}"
fi
if [ -f "${gtk_4_settings}" ];
then
    sed -e "/gtk-application-prefer-dark-theme/s/=.*/=false/" \
        -e "/gtk-theme-name/s/=.*/=${gtk_theme}/" \
        -i "${gtk_4_settings}"
fi

# QT Settings {{{1
if command -v kvantummanager > /dev/null; then
    kvantummanager --set "${qt_theme}"
fi

# Alacritty Settings {{{1
alacritty_settings="$HOME/.config/alacritty/alacritty.toml"
if [ -f "${alacritty_settings}" ]; then
    sed -i "/theme/s/\[.*\]/[\"${alacritty_theme}\"]/" "${alacritty_settings}"
fi

# Sway settings {{{1
sway_settings="$HOME/.config/sway/config"
if [ -n "$SWAYSOCK" ] &&
    command -v swaymsg > /dev/null; then
    #sed -e "/output eDP-1 bg/s/backgrounds\/.*/backgrounds\/${wallpaper//\//\\\/} fill/" \
    sed -e "/include themes/s/themes\/.*/themes\/${sway_theme}/" \
        -i "${sway_settings}"
    swaymsg reload
fi

# Hyprland settings {{{1
#hyprland_settings="$HOME/.config/hypr/hyprland.conf"
#hyprpaper_settings="$HOME/.config/hypr/hyprpaper.conf"
#wallpaper_dir="$HOME/Pictures/backgrounds/"
#if [ -n "$HYPRLAND_CMD" ] && command -v hyprpaper > /dev/null; then
#    # Wallpaper
#    hyprctl hyprpaper wallpaper ",${wallpaper_dir}${wallpaper}"
#    sed -i "/^\s*path/s/=.*/= ${wallpaper_dir//\//\\\/}${wallpaper//\//\\\/}/" "${hyprpaper_settings}"
#fi
# Hy3
sed -i "/colorscheme/s/themes\/[^ ]\+/themes\/${hyprland_theme}/" "${hyprland_settings}"

# Waybar settings {{{1
waybar_style="$HOME/.config/waybar/style.css"
sed -i "/colorscheme/s/themes\/[^\"]\+/themes\/${waybar_theme}/" "${waybar_style}"

. $HOME/.config/waybar/waybar.sh # Restart waybar

# Zathura settings {{{1
zathura_conf_d="$HOME/.config/zathura"
zathura_settings="${zathura_conf_d}/zathurarc"
zathura_template="${zathura_conf_d}/zathurarc.j2"
if [ -d "${zathura_conf_d}" ] &&
    [ -f "${zathura_template}" ] &&
    command -v jq >/dev/null &&
    command -v minijinja-cli > /dev/null; then
    jq -Rs '{ theme: . }' "${zathura_conf_d}/${zathura_theme}" | minijinja-cli -f json "${zathura_template}" - > "${zathura_settings}"
fi

# Wofi settings {{{1
wofi_conf_d="$HOME/.config/wofi"
wofi_style="${wofi_conf_d}/style.css"
if [ -d "${wofi_conf_d}" ] && [ -f "${wofi_conf_d}/${wofi_theme}" ]; then
    if [ -f "${wofi_style}" ]; then
        rm "${wofi_style}"
    fi
    ln -s "${wofi_theme}" "${wofi_style}"
fi

# Zellij Settings {{{1
zellij_settings="$HOME/.config/zellij/config.kdl"
if [ -f "${zellij_settings}" ]; then
    sed -i "/^\(\/\/ \)\?theme/s/^.*$/theme \"${zellij_theme}\"/" "${zellij_settings}"
fi

# Delta Settings {{{1
gitconfig="$HOME/.gitconfig"
if [ -f "${gitconfig}" ]; then
    sed -e "/delta-theme/s/=\s*[^#]*/= ${delta_theme} /" \
        -e "/delta-syntax-theme/s/=\s*[^#]*/= ${delta_syntax_theme} /" \
        -i "${gitconfig}"
fi

# Commandline tools {{{1
zsh_themes="$HOME/.zsh/.zsh_themes"
if [ -f "${zsh_themes}" ]; then
    sed -e "/BAT_THEME=/s/=.*/=\"${bat_theme}\"/" \
        -e "/BTM_THEME=/s/=.*/=${btm_theme}/" \
        -e "/fzf-theme/s/source [^#]*/source ~\/.config\/catppuccin\/fzf\/themes\/${fzf_theme}.sh /" \
        -i "${zsh_themes}"
fi

# vim: foldmethod=marker
