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
WALLPAPER_DARK="wallpaperaccess\\/flat\\/160352.png fill"
WALLPAPER_LIGHT="wallpaperaccess\\/light-pink\\/1250031.jpg fill"
ZATHURA_THEME_LIGHT=zathura-gruvbox/zathura-gruvbox-light
ZATHURA_THEME_DARK=zathura-gruvbox/zathura-gruvbox-dark
WOFI_THEME_DARK=quantumfate/src/macchiato/style.css
WOFI_THEME_LIGHT=quantumfate/src/latte/style.css

BTM_THEME_DARK=gruvbox
BTM_THEME_LIGHT=default
BAT_THEME_DARK=gruvbox-dark
BAT_THEME_LIGHT=gruvbox-light

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
    wallpaper=$WALLPAPER_LIGHT
    zathura_theme=$ZATHURA_THEME_LIGHT
    wofi_theme=$WOFI_THEME_LIGHT

    btm_theme=$BTM_THEME_LIGHT
    bat_theme=$BAT_THEME_LIGHT
else
    gsettings set org.gnome.desktop.interface color-scheme prefer-dark
    gtk_theme=$GTK_THEME_DARK
    qt_theme=$QT_THEME_DARK
    alacritty_theme=$ALACRITTY_THEME_DARK
    sway_theme=$SWAY_THEME_DARK
    wallpaper=$WALLPAPER_DARK
    zathura_theme=$ZATHURA_THEME_DARK
    wofi_theme=$WOFI_THEME_DARK

    btm_theme=$BTM_THEME_DARK
    bat_theme=$BAT_THEME_DARK
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
    sed -e "/output HDMI-A-1 bg/s/backgrounds\/.*/backgrounds\/${wallpaper}/" \
        -e "/include themes/s/themes\/.*/themes\/${sway_theme}/" \
        -i "${sway_settings}"
    swaymsg reload
fi

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

# Commandline tools {{{1
zsh_themes="$HOME/.zsh/.zsh_themes"
if [ -f "${zsh_themes}" ]; then
    sed -e "/BAT_THEME=/s/=.*/=${bat_theme}/" \
        -e "/BTM_THEME=/s/=.*/=${btm_theme}/" \
        -i "${zsh_themes}"
fi

# vim: foldmethod=marker
