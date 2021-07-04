# Add authentication information

if [ -f ~/.bash_passwords ]; then
    . ~/.bash_passwords
fi

export NLTK_DATA="/mnt/LENOVO/Data/NLTK"

if [ "$SSH_CONNECTION" ]; then
    SSH_SESSION=$(echo "$SSH_CONNECTION" | base64)
    export P_THEME="/home/heyrict/.prev_theme_$SSH_SESSION"
else
    export P_THEME="/home/heyrict/.prev_theme"
fi

# SSLVPN
alias easyconnect="docker run --device /dev/net/tun --cap-add NET_ADMIN -ti -p 127.0.0.1:1080:1080 -e EC_VER=7.6.7 hagb/docker-easyconnect:cli"
alias px8123="export https_proxy=http://127.0.0.1:8123 http_proxy=http://127.0.0.1:8123"


# Extension to git merge
alias gmn="git merge --no-commit"
alias gmnn="git merge --no-commit --no-ff"

# 2048.c default theme
alias 2048="2048 bluered"

## Mimic xbox360 driver with SHANWAN Generic joystick using xboxdrv
#alias mimic-xbox="sudo xboxdrv \
#   --evdev /dev/input/by-id/usb-Sony_Interactive_Entertainment_Wireless_Controller-event-if03\
#   --evdev-absmap ABS_X=x1,ABS_Y=y1                 \
#   --evdev-absmap ABS_Z=x2,ABS_RZ=y2                \
#   --evdev-absmap ABS_HAT0X=dpad_x,ABS_HAT0Y=dpad_y \
#   --evdev-keymap BTN_A=x,BTN_B=a                   \
#   --evdev-keymap BTN_C=b,BTN_X=y                   \
#   --evdev-keymap BTN_Y=lb,BTN_Z=rb                 \
#   --evdev-keymap BTN_TL=lt,BTN_TR=rt               \
#   --evdev-keymap BTN_SELECT=tl,BTN_START=tr        \
#   --evdev-keymap BTN_TL2=back,BTN_TR2=start        \
#   --evdev-keymap BTN_MODE=guide                    \
#   --axismap -y1=y1,-y2=y2                          \
#   --mimic-xpad                                     \
#   --silent
#"

alias mimic-xbox="xboxdrv \
    --evdev /dev/input/by-id/usb-Sony_Interactive_Entertainment_Wireless_Controller-if03-event-joystick \
    --evdev-absmap ABS_X=x1,ABS_Y=y1                 \
    --evdev-absmap ABS_Z=x2,ABS_RZ=y2                \
    --evdev-absmap ABS_HAT0X=dpad_x,ABS_HAT0Y=dpad_y \
    --evdev-keymap BTN_A=x,BTN_B=a                   \
    --evdev-keymap BTN_C=b,BTN_X=y                   \
    --evdev-keymap BTN_Y=lb,BTN_Z=rb                 \
    --evdev-keymap BTN_TL=lt,BTN_TR=rt               \
    --evdev-keymap BTN_SELECT=tl,BTN_START=tr        \
    --evdev-keymap BTN_TL2=back,BTN_TR2=start        \
    --evdev-keymap BTN_MODE=guide                    \
    --axismap -y1=y1,-y2=y2                          \
    --mimic-xpad                                     \
    --silent"

# virtualenv
activate() {
    source ~/$1/bin/activate;
}

# aria2c with rpc enabled
alias aria2cd="aria2c --enable-rpc"

# vim without language server
alias ncvim='NOCOMPL=true vim'
alias ncnvim='NOCOMPL=true nvim'

# gifview
alias gifview="gifview --min-delay=10 -a"

# nnn
alias nnn='nnn -x'

# ssh related
alias ssh_through_proxy='ssh -o "ProxyCommand=nc -X connect -x localhost:8123 %h %p"'

# mitmproxy override
alias mitmoverride="mitmproxy --anticache -s ~/Programs/mitmproxy-resource-override/mitmResourceOverride.py"

# prevent errors on suspend
## normal version
#alias susp="sudo modprobe -r ath10k_pci; systemctl suspend"
#alias unsusp="sudo modprobe ath10k_pci"
#alias hiber="sudo modprobe -r ath10k_pci; sudo systemctl hibernate"
## tmux favored
alias susp="wifi off; systemctl suspend"
alias unsusp="wifi on"
alias hiber="wifi off; sudo systemctl hibernate"
## check modprobe before rmmod
#susp(){
#    if [[ $(modprobe -rnv ath10k_pci) ]]
#    then sudo modprobe -r ath10k_pci
#    fi
#    systemctl suspend
#}
#unsusp(){
#    if [[ $(modprobe -nv ath10k_pci) ]]
#    then sudo modprobe ath10k_pci
#    fi
#}
#hiber(){
#    if [[ $(modprobe -rnv ath10k_pci) ]]
#    then sudo modprobe -r ath10k_pci
#    fi
#    sudo systemctl hibernate
#}

# hosts
#alias hosts_download="wget https://coding.net/u/scaffrey/p/hosts/git/raw/master/hosts-files/hosts"

# aria2c bt trackers
alias fetch_trackers='sed -i "s@^\(bt-tracker=\).*@\1$(curl -s -L https://raw.githubusercontent.com/ngosang/trackerslist/master/trackers_all_ip.txt | sed "/^\s*$/d" | tr "\n" ",")@" ~/.aria2/aria2.conf'

# Colored ytop
alias ytop='if [ $BACKLIGHT = light ]; then ytop -c default-dark; else ytop; fi'

# 8-bit color for fbterm
alias eight-dark='export TERM=fbterm; export BACKLIGHT=dark; ~/MyPrograms/shell/solarized-dark-fbterm.sh; clear; echo $BACKLIGHT > $P_THEME'
alias eight-light='export TERM=fbterm; export BACKLIGHT=light; ~/MyPrograms/shell/solarized-light-fbterm.sh; clear; echo $BACKLIGHT > $P_THEME'
alias eight='eight-dark'
alias bg-dark="export BACKLIGHT=dark; vim --clean ~/.config/alacritty/alacritty.yml -c '%s/\*solarized_light/\*solarized_dark/' -c 'wq'; export BAT_THEME=OneHalfDark; echo dark > $P_THEME"
alias bg-light="export BACKLIGHT=light; vim --clean ~/.config/alacritty/alacritty.yml -c '%s/\*solarized_dark/\*solarized_light/' -c 'wq'; export BAT_THEME='Monokai Extended Light'; echo light > $P_THEME"

if [ -f $P_THEME ]; then
  if [ `cat $P_THEME` = light ]; then
    export BAT_THEME="Monokai Extended Light";
    export BACKLIGHT=light;
  else
    export BAT_THEME="OneHalfDark";
    export BACKLIGHT=dark;
  fi
fi

# 256 color for tmux
if [ $TMUX ]; then
    TERM="xterm-256color"
fi

# sl == ls
alias sl="ls"

# fbi preference
alias fbi='fbi -P'

# pandoc template
#eval "$(pandoc --bash-completion)"
#alias pandoc2chspdf="pandoc --template=$HOME/模板/chs_template.tex --pdf-engine=xelatex -M 'CJKmainfont:WenQuanYi Micro Hei' --biblio $HOME/Tex/MyRef.bib"
#alias pandoc="pandoc --filter pandoc-tablenos -s"
alias pandoc="pandoc -s"
alias pandoc2mermaid="pandoc -c ~/assets/css/github-pandoc.css --template ~/assets/css/mermaid_template.html5 --filter pandoc-mermaid"
alias pandoc2mermaidpdf="pandoc --filter pandoc-imagine --pdf-engine=xelatex -M 'CJKmainfont:WenQuanYi Micro Hei'"
alias pandoc2chs="pandoc --pdf-engine=xelatex -M 'CJKmainfont:WenQuanYi Micro Hei' --biblio $HOME/Tex/MyRef.bib"
alias pandoc2chspdf="pandoc2chs --template=$HOME/.pandoc/default.latex ~/pandoc_markdown/CHS_METADATA.yaml"

# octave preference
alias octave="octave --no-gui"

# backup savedata
alias backup_savedata="just -f ~/Nutstore/backup/justfile -d ~/Nutstore/backup/justfile"

# sync android savedata files
alias android_push="adb push --sync /mnt/LENOVO/Eric/psp/memstick/PSP/SAVEDATA/* /sdcard/Download/RetroGames/psp/memstick/PSP/SAVEDATA/"
alias android_pull="adb pull -a /sdcard/Download/RetroGames/psp/memstick/PSP/SAVEDATA/ /tmp/psp_android_sync; rsync -puir /tmp/psp_android_sync/ /mnt/LENOVO/Eric/psp/memstick/PSP/SAVEDATA/; rm -r /tmp/psp_android_sync"
alias android_sync="android_push; android_pull"

# pipe dict to less
#d(){ dict $* | colorit | less -R; }
#dictc() {
#    echo -n '> '
#    read word
#    while [ "$word" ]; do
#        if [ "$word" = "" ]; then
#            clear
#        else
#            dict $word | colorit | less -R
#        fi
#        echo -n '> '
#        read word
#    done
#}


# brightness
alias backlight_off="sleep 1; xset dpms force off"

set_brightness() {
    if [ $# -eq 0 ]; then
        vim /sys/class/backlight/intel_backlight/brightness
    else
        echo "$1" > /sys/class/backlight/intel_backlight/brightness
    fi
}
#show_brightness(){
#    echo $(cat /sys/class/backlight/intel_backlight/brightness):$(cat /sys/class/backlight/intel_backlight/max_brightness)
#}

# battery preference
alias show_capacity='echo $(cat /sys/class/power_supply/BAT1/capacity)%;'

# Change opacity of alacritty
altrans() {
    if [ $# -eq 0 ]; then
        rg background_opacity ~/.config/alacritty/alacritty.yml | awk '{print $2}'
    else
        vim --clean ~/.config/alacritty/alacritty.yml\
            -c "%s/^background_opacity:[0-9 .]*$/background_opacity: $1/"\
            -c "wq"
    fi
}

alias increase_inotify="sudo sysctl -w fs.inotify.max_user_watches=100000"
