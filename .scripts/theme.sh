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
WALLPAPER_LIGHT="wallpaperaccess\\/flat\\/203545.jpg fill"

BTM_THEME_DARK=gruvbox
BTM_THEME_LIGHT=default
BAT_THEME_DARK=gruvbox-dark
BAT_THEME_LIGHT=gruvbox-light

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

    btm_theme=$BTM_THEME_LIGHT
    bat_theme=$BAT_THEME_LIGHT
else
    gsettings set org.gnome.desktop.interface color-scheme prefer-dark
    gtk_theme=$GTK_THEME_DARK
    qt_theme=$QT_THEME_DARK
    alacritty_theme=$ALACRITTY_THEME_DARK
    sway_theme=$SWAY_THEME_DARK
    wallpaper=$WALLPAPER_DARK

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
kvantummanager --set "${qt_theme}"

# Alacritty Settings {{{1
alacritty_settings="$HOME/.config/alacritty/alacritty.toml"
if [ -f "${alacritty_settings}" ]; then
    sed -i "/theme/s/\[.*\]/[\"${alacritty_theme}\"]/" "${alacritty_settings}"
fi

# Sway settings {{{1
sway_settings="$HOME/.config/sway/config"
if [ -n "$SWAYSOCK" ]; then
    sed -e "/output HDMI-A-1 bg/s/backgrounds\/.*/backgrounds\/${wallpaper}/" \
        -e "/include themes/s/themes\/.*/themes\/${sway_theme}/" \
        -i "${sway_settings}"
    swaymsg reload
fi

. $HOME/.config/waybar/waybar.sh # Restart waybar

# Commandline tools {{{1
zsh_themes="$HOME/.zsh/.zsh_themes"
if [ -f "${zsh_theme}" ]; then
    sed -e "/BAT_THEME=/s/=.*/=${bat_theme}/" \
        -e "/BTM_THEME=/s/=.*/=${btm_theme}/" \
        -i "${zsh_themes}"
fi

# vim: foldmethod=marker
