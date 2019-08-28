# Add authentication information

if [ -f ~/.bash_passwords ]; then
    . ~/.bash_passwords
fi

# Android Env
export ANDROID_HOME="$HOME/Android"
export ANDROIDSDK="$HOME/Android"
export ANDROIDNDK="/opt/crystax-ndk-10.3.2"
#export ANDROIDAPI="26"

export APP_ANDROID_SDK_PATH="$HOME/Android"
export APP_ANDROID_NDK_PATH="/opt/crystax-ndk-10.3.2"
export APP_ANDROID_ANT_PATH="/opt/apache-ant-1.9.4"
#export APP_ANDROID_API="26"
export APP_P4A_SOURCE_DIR="/usr/local/lib/python3.5/dist-packages/pythonforandroid"

export NLTK_DATA="/media/heyrict/LENOVO/Data/NLTK"

export LAPTOP_MODE="$(cat /proc/sys/vm/laptop_mode)"

# node with global node_modules
alias gnode="NODE_PATH=\"/home/heyrict/.nvm/versions/node/v10.7.0/lib/node_modules/\" node"

# Mimic xbox360 driver with SHANWAN Generic joystick using xboxdrv
alias mimic-xpad="sudo xboxdrv --evdev /dev/input/by-id/usb-SHANWAN_Android_Gamepad-event-joystick --evdev-absmap ABS_X=x1,ABS_Y=y1,ABS_RZ=x2,ABS_Z=y2,ABS_HAT0X=dpad_x,ABS_HAT0Y=dpad_y --axismap -Y1=Y1,-Y2=Y2 --evdev-keymap BTN_NORTH=x,BTN_WEST=y,BTN_EAST=a,BTN_SOUTH=b,BTN_THUMBL=tl,BTN_THUMBR=tr,BTN_TL=lt,BTN_TR=rt,BTN_TL2=lb,BTN_TR2=rb,BTN_SELECT=back,BTN_MODE=guide,BTN_START=start --axis-sensitivity Y1=-0.6,Y2=-0.6,X1=-0.6,X2=-0.6 --mimic-xpad --silent --detach-kernel-driver"
alias mimic-keyboard="sudo xboxdrv --evdev /dev/input/by-id/usb-SHANWAN_Android_Gamepad-event-joystick --evdev-absmap ABS_X=x1,ABS_Y=y1,ABS_RZ=x2,ABS_Z=y2,ABS_HAT0X=dpad_x,ABS_HAT0Y=dpad_y --axismap -Y1=Y1,-Y2=Y2 --evdev-keymap BTN_NORTH=x,BTN_WEST=y,BTN_EAST=a,BTN_SOUTH=b,BTN_THUMBL=tl,BTN_THUMBR=tr,BTN_TL=lt,BTN_TR=rt,BTN_TL2=lb,BTN_TR2=rb,BTN_SELECT=back,BTN_MODE=guide,BTN_START=start --axis-sensitivity Y1=-0.6,Y2=-0.6,X1=-0.6,X2=-0.6 --dpad-as-button --trigger-as-button --ui-axismap x1=KEY_LEFT:KEY_RIGHT,y1=KEY_UP:KEY_DOWN,x2=KEY_A:KEY_D,y2=KEY_W:KEY_S,trigger=REL_WHEEL:5:100 --ui-buttonmap a=KEY_X,b=KEY_C,x=KEY_S,y=KEY_A,rb=KEY_PAGEDOWN,lb=KEY_PAGEUP,lt=BTN_LEFT,rt=KEY_ESC,tl=KEY_T,tr=KEY_Y,dl=KEY_LEFT,dr=KEY_RIGHT,du=KEY_UP,dd=KEY_DOWN,start=KEY_FORWARD,back=KEY_BACK,guide=KEY_ESC --silent --detach-kernel-driver"
alias mimic-xbox="sudo xboxdrv \
   --evdev /dev/input/by-id/usb-Sony_Interactive_Entertainment_Wireless_Controller-event-if03\
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
   --silent
"

# virtualenv
activate() {
    source ~/$1/bin/activate;
}

# ssh related
alias ssh_through_proxy='ssh -o "ProxyCommand=nc -X connect -x localhost:8123 %h %p"'

# fix-tensorflow
#export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/usr/local/cuda-8.0/lib64:/usr/local/cuda-8.0/extras/CUPTI/lib64:/usr/local/cuda-8.0/targets/x86_64-linux/lib/"
#alias fixtf="sudo modprobe --force-modversion nvidia-396-uvm"

# mitmproxy override
alias mitmoverride="mitmproxy --anticache -s ~/Eric/Program_Files/mitmproxy-resource-override/mitmResourceOverride.py"

# HDMI output redirect settings
alias HDMIConfigure="xrandr --output HDMI-1 --scale-from 1366x768 --panning 1366x768+0+0/1366x768+0+0/64/64/64/64"

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

# git
alias git_log="git log --oneline --all --decorate --graph"

# 8-bit color for fbterm
alias eight-dark='export TERM=fbterm; export BACKLIGHT=dark; echo -e "\e]R \e]P0002B36 \e]P7839496"; clear'
alias eight-light='export TERM=fbterm; export BACKLIGHT=light; echo -e "\e]R \e]P0FDF6E3 \e]P7657B83"; clear'
alias eight='eight-dark'
alias bg-dark="export BACKLIGHT=dark"
alias bg-light="export BACKLIGHT=light; export TASKRC=~/.lighttaskrc;"

#alias viml='\vim -c "set background=light"'
#alias vimd='\vim -c "set background=dark"'
#alias vim='vimd'

# 256 color for tmux
if [ $TMUX ]; then
    TERM="screen-256color"
fi

# sl == ls
alias sl="ls"

# using c++11
#alias g++='g++ -std=c++11'

# qtcreator stylesheets
#alias qtcreatordk="qtcreator -theme dark -stylesheet ~/.config/QtProject/qtcreator/codestyles/darcula/darcula.css"

# fbi preference
alias fbi='fbi -P'

# colorit preference
alias coloritmd='colorit -c ~/Templates/md.coloritrc'
alias coloritdef='colorit -c ~/Templates/def.coloritrc'
alias coloritpy='colorit -c ~/Templates/python.coloritrc'

# generate pyqt5 gui frontend
#alias pyqtgen='cp /home/heyrict/Eric/backup/pyqt.template.py'

# pandoc template
#eval "$(pandoc --bash-completion)"
#alias pandoc2chspdf="pandoc --template=$HOME/模板/chs_template.tex --pdf-engine=xelatex -M 'CJKmainfont:WenQuanYi Micro Hei' --biblio $HOME/Tex/MyRef.bib"
alias pandoc="pandoc --filter pandoc-tablenos -s"
alias pandoc2mermaid="pandoc -c ~/Templates/github-pandoc.css --template ~/Templates/mermaid_template.html5 --filter pandoc-mermaid"
alias pandoc2mermaidpdf="pandoc --filter pandoc-imagine --pdf-engine=xelatex -M 'CJKmainfont:WenQuanYi Micro Hei'"
alias pandoc2chs="pandoc --pdf-engine=xelatex -M 'CJKmainfont:WenQuanYi Micro Hei' --biblio $HOME/Tex/MyRef.bib"
alias pandoc2chspdf="pandoc2chs --template=$HOME/.pandoc/default.latex ~/pandoc_markdown/CHS_METADATA.yaml"

# often-use programs
export PATH=$PATH:~/Eric/MyPrograms/bin:~/Eric/Program_Files/bin:$HOME/Android/platform-tools:~/Eric/Program_Files/java-jars

# fbterm preference
#alias white_fontcolor="echo -en \"\e]P7ffffff\""
#alias default_fontcolor="echo -en \"\e]R\""


# octave preference
alias octave="octave --no-gui"

# rm-protect
#alias cp="cp -i"
#alias rm="rm-p"

# ppsspp savedata control
#alias ppsspp="test -d /media/heyrict/LENOVO/Eric/psp/ && ppsspp || echo 'Folder not exist: /media/heyrict/LENOVO/Eric/psp/, exit.'"
#alias PPSSPP="ppsspp"

# nds savedata control
alias backup_microsd="\cp -puv /media/heyrict/R4/rom/*.SAV /home/heyrict/Eric/backup/nds/; \cp -puv /media/heyrict/R4/rom/*.SAV /media/heyrict/LENOVO/Eric/nds/microSD\ backup/rom/"

# backup savedata
#alias backup_savedata="\cp -puv ~/Eric/backup/nds/* ~/NutStore/backup/nds/; \cp -puvr /media/heyrict/LENOVO/Eric/ps2/PCSX2\ 1.4.0/memcards/*.ps2 ~/NutStore/backup/ps2; \cp -puvr /media/heyrict/LENOVO/Eric/psp/memstick/PSP/SAVEDATA/ ~/NutStore/backup/psp; \cp -puvr /media/heyrict/LENOVO/Eric/ps3/dev_hdd0/home/ ~/NutStore/backup/ps3; rm ~/NutStore/backup/ps3/home/*/trophy/*/TROP*.PNG"
alias backup_savedata="rsync -pui ~/Eric/backup/nds/* ~/NutStore/backup/nds/; rsync -puir /media/heyrict/LENOVO/Eric/ps2/PCSX2\ 1.4.0/memcards/*.ps2 ~/NutStore/backup/ps2; rsync -puir /media/heyrict/LENOVO/Eric/psp/memstick/PSP/SAVEDATA/ ~/NutStore/backup/psp; rsync -puvr --exclude=TROP*.PNG /media/heyrict/LENOVO/Eric/ps3/dev_hdd0/home/* ~/NutStore/backup/ps3; rsync -puir /media/heyrict/LENOVO/Eric/wii/Dolphin-x64/Sys/Wii/title/ ~/NutStore/backup/wii"

# sync android savedata files
alias android_push="\cp -puvr /media/heyrict/LENOVO/Eric/psp/memstick/PSP/SAVEDATA/ /tmp/psp_android_sync; adb push --sync /tmp/psp_android_sync/* /sdcard/Download/RetroGames/psp/memstick/PSP/SAVEDATA/; rm -r /tmp/psp_android_sync"

# pipe dict to less
d(){ dict $* | colorit | less -R; }

# cd to specified directories
alias wd="cd /home/heyrict/Eric/MyPrograms"
alias cindy="cd /home/heyrict/Eric/MyPrograms/web/cindy"

#excute_program_in_specific_dir(){
#local curdir=$(pwd)
#cd $2
#./$1 ${@:3}
#cd $curdir
#}

## temporary custom programs
#alias revise="excute_program_in_specific_dir revise.py /home/heyrict/Eric/MyPrograms/exam/revise"
#alias SysAna="excute_program_in_specific_dir sysana.py /home/heyrict/Eric/MyPrograms/exam/SysAna"
#alias Sat6="excute_program_in_specific_dir engmain.py /home/heyrict/Eric/MyPrograms/exam/English_words"

#alias zotero="excute_program_in_specific_dir zotero ~/Eric/Program_Files/Zotero_linux-x86_64"
#alias xmind="excute_program_in_specific_dir XMind /opt/XMind/XMind_amd64"

#xmind(){
#local OPTIND
#while getopts it opt
#do
#  case "$opt" in
#    i) local Interactive=1;;
#    t) local Interactive=1;;
#  esac
#done
#shift $[ $OPTIND - 1 ]
#
#if [ ! $Interactive ]; then local Interactive=0; fi
#
#local curdir=$(pwd)
#cd /opt/XMind/XMind_amd64/
#if [ $# = 0 ]
#then
#  if [ $Interactive = 0 ]
#    then ./XMind
#  else find -name '*.xmind'
#  fi
#else
# local all=""
# for word in $*
# do
#   all=$all"_"$word
# done
# echo "-----------------"
# local found=($(find -name '*.xmind' | grep ".*/${all:1}[^/]*$"))
# if [ ${#found[@]} = 1 ] ; then
#   echo "One File Found."
#   echo ${found[0]}
#   echo "-----------------"
#   if [ $Interactive = 0 ]; then
#     ./XMind ${found[0]}
#   fi
# elif [ ${#found[@]} = 0 ]; then
#   echo "No matching file found. Exit."
#   echo "-----------------"
# else
#   echo "More than one file found."
#   for ((i = 0 ; i < ${#found[@]} ; ++i )); do
#     echo -e "$i\t${found[$i]}"
#   done
#   echo "-----------------"
#   if [ $Interactive = 0 ]; then
#     local choose
#     read -p "Which one to choose? " choose
#     if [[ $choose < ${#found[@]} ]]; then
#     ./XMind ${found[$choose]}
#     fi
#   fi
#   echo
# fi
#fi
#cd $curdir
#return 0
#}

# indicators

# brightness

alias set_brightness="vim /sys/class/backlight/intel_backlight/brightness"
alias backlight_off="xset dpms force off"
#show_brightness(){
#    echo $(cat /sys/class/backlight/intel_backlight/brightness):$(cat /sys/class/backlight/intel_backlight/max_brightness)
#}
#indicator_brightness(){
# local indent='5m'
# if [[ $# > 0 ]]
# then
#  indent=$1
# fi
# while true
# do
#  clear
#  show_brightness
#  sleep $indent
# done
#}

# battery preference
show_capacity(){ echo $(cat /sys/class/power_supply/BAT1/capacity)%;}
#indicator_battery(){
# local indent='5m'
# if [[ $# > 0 ]]
# then
#  indent=$1
# fi
# while true
# do
#  clear
#  show_capacity
#  sleep $indent
# done
#}

## run splash in docker
#splash(){
#sudo docker stop c4
#sudo docker run -p 8050:8050 scrapinghub/splash
#}

## paper search engine
alias webofscience="browse http://apps.webofknowledge.com/"
alias sciencedirect="browse http://www.sciencedirect.com/"
pubmed(){
if test $# -eq 0
then
    browse https://www.ncbi.nlm.nih.gov/pubmed
else
    local str=""
    for i in $*;do str=$str"+"$i;done
    browse https://www.ncbi.nlm.nih.gov/pubmed?term=${str:1}
fi
}
pmid(){
    browse https://www.ncbi.nlm.nih.gov/pubmed/$1
}

#ncbi(){
#if test $# -eq 0
#then
#    browse https://www.ncbi.nlm.nih.gov/
#else
#    local str=""
#    for i in $*;do str=$str"+"$i;done
#    browse https://www.ncbi.nlm.nih.gov/gquery/?term=${str:1}
#fi
#}
#
#nature(){
#if test $# -eq 0
#then
#    browse https://www.nature.com/
#else
#    local str=""
#    for i in $*;do str=$str"+"$i;done
#    browse https://www.nature.com/search?q=${str:1}
#fi
#}

wanfang(){
if test $# -eq 0
then
    browse http://s.g.wanfangdata.com.cn
else
    local str=""
    for i in $*;do str=$str"+"$i;done
    browse http://s.g.wanfangdata.com.cn/Paper.aspx?q=${str:1}
fi
}

# color palettes
#color_palette(){
#    for i in {0..255}
#    do
#        echo -en "\e[48;5;${i}mc${i}\e[0m\t"
#        if [ $[${i} % 16] = 15 ]
#        then
#            echo
#        fi
#    done
#    echo
#}
alias increase_inotify="sudo sysctl -w fs.inotify.max_user_watches=100000"
