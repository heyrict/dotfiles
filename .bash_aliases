# Add authentication information

if [ -f ~/.bash_passwords ]; then
    . ~/.bash_passwords
fi

# Android Env
#export ANDROIDSDK="$HOME/Android/Sdk"
export ANDROIDSDK="$HOME/Android/OriginalSdk"
export ANDROIDNDK="/opt/crystax-ndk-10.3.2"
#export ANDROIDAPI="26"

export APP_ANDROID_SDK_PATH="$HOME/Android/OriginalSdk"
export APP_ANDROID_NDK_PATH="/opt/crystax-ndk-10.3.2"
export APP_ANDROID_ANT_PATH="/opt/apache-ant-1.9.4"
#export APP_ANDROID_API="26"
export APP_P4A_SOURCE_DIR="/usr/local/lib/python3.5/dist-packages/pythonforandroid"

export LAPTOP_MODE="$(cat /proc/sys/vm/laptop_mode)"

# Two firefox
alias fde="~/Eric/Program_Files/firefox/firefox"

# virtualenv
activate() {
    source ~/$1/bin/activate;
}

# fix-tensorflow
export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/usr/local/cuda-8.0/lib64:/usr/local/cuda-8.0/extras/CUPTI/lib64:/usr/local/cuda-8.0/targets/x86_64-linux/lib/"
alias fixtf="sudo modprobe --force-modversion nvidia-390-uvm"

# mitmproxy override
alias mitmoverride="mitmproxy -s ~/Eric/Program_Files/mitmproxy-resource-override/mitmResourceOverride.py"

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

# git
alias git_log="git log --oneline --all --decorate --graph"

# 8-bit color for fbterm
alias eight-dark='TERM=fbterm; echo -e "\e]R \e]P0002B36 \e]P7839496"; clear'
alias eight-light='TERM=fbterm; echo -e "\e]R \e]P0FDF6E3 \e]P7657B83"; clear'
alias eight='eight-dark'

alias viml='\vim -c "set background=light"'
alias vimd='\vim -c "set background=dark"'
alias vim='vimd'

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
alias coloritmd='colorit -c ~/Templates/.md.coloritrc'
alias coloritdef='colorit -c ~/Templates/.def.coloritrc'
alias coloritpy='colorit -c ~/Templates/.python.coloritrc'

# generate pyqt5 gui frontend
#alias pyqtgen='cp /home/ericx/Eric/backup/pyqt.template.py'

# pandoc template
#eval "$(pandoc --bash-completion)"
#alias pandoc2chspdf="pandoc --template=$HOME/模板/chs_template.tex --latex-engine=xelatex -M CJKmainfont:文泉驿微米黑 --biblio $HOME/Tex/MyRef.bib" 
alias pandoc="pandoc --filter pandoc-tablenos -s"
alias pandoc2mermaid="pandoc -c ~/Templates/github-pandoc.css --template ~/Templates/mermaid_template.html5 --filter pandoc-mermaid"
alias pandoc2mermaidpdf="pandoc --filter pandoc-imagine --latex-engine=xelatex -M CJKmainfont:文泉驿微米黑"
alias pandoc4django="pandoc -c \"{% static 'github-pandoc.css' %}\" --template ~/Templates/django_template.html5"
alias pandoc2chs="pandoc --latex-engine=xelatex -M CJKmainfont:文泉驿微米黑 --biblio $HOME/Tex/MyRef.bib" 
alias pandoc2chspdf="pandoc2chs --template=$HOME/.pandoc/default.latex ~/pandoc_markdown/CHS_METADATA.yaml"

# often-use programs
export PATH=$PATH:~/Eric/MyPrograms/bin:~/Eric/Program_Files/bin:/opt/android-ndk-r10e:~/Qt5.9.1/Tools/QtCreator/bin:~/Qt5.9.1/5.9.1/gcc_64/bin:$HOME/arm-linux-androideabi/arm-linux-androideabi/bin:$HOME/arm-linux-androideabi/arm-linux-androideabi/lib/

# fbterm preference
#alias white_fontcolor="echo -en \"\e]P7ffffff\""
#alias default_fontcolor="echo -en \"\e]R\""


# octave preference
alias octave="octave --no-gui"

# rm-protect
alias cp="cp -i"
alias rm="rm-p"

# ppsspp savedata control
alias sync_psp_data_from_Lenovo="\cp -uvr /media/ericx/LENOVO/Eric/psp/memstick/PSP/SAVEDATA/* ~/.config/ppsspp/PSP/SAVEDATA"
alias sync_psp_data_to_Lenovo="\cp -uvr ~/.config/ppsspp/PSP/SAVEDATA/* /media/ericx/LENOVO/Eric/psp/memstick/PSP/SAVEDATA/"

# ppsspp savedata control
alias sync_ps2_data_from_Lenovo="\cp -uvr /media/ericx/LENOVO/Eric/ps2/PCSX2\ 1.4.0/memcards/*.ps2 ~/.config/PCSX2/memcards/"
alias sync_ps2_data_to_Lenovo="\cp -uvr ~/.config/PCSX2/memcards/*.ps2 /media/ericx/LENOVO/Eric/ps2/PCSX2\ 1.4.0/memcards/"


# nds savedata control
alias backup_microsd="\cp -uv /media/ericx/R4/rom/*.SAV /home/ericx/Eric/backup/nds/; \cp -uv /media/ericx/R4/rom/*.SAV /media/ericx/LENOVO/Eric/nds/microSD\ backup/rom/"

# backup savedata
alias nutstore="~/.nutstore/dist/bin/nutstore-pydaemon.py"
alias backup_savedata="\cp -uv ~/Eric/backup/nds/* ~/NutStore/backup/nds/; \cp -uv ~/.config/PCSX2/memcards/* ~/NutStore/backup/ps2; \cp -uvr ~/.config/ppsspp/PSP/SAVEDATA/ ~/NutStore/backup/psp"

# pipe dict to less
d(){ dict $* | less; }

# cd to specified directories
alias wd="cd /home/ericx/Eric/MyPrograms"
alias cindy="cd /home/ericx/Eric/MyPrograms/django/cindy"

excute_program_in_specific_dir(){
local curdir=$(pwd)
cd $2
./$1 ${@:3}
cd $curdir
}

## temporary custom programs
#alias revise="excute_program_in_specific_dir revise.py /home/ericx/Eric/MyPrograms/exam/revise"
#alias SysAna="excute_program_in_specific_dir sysana.py /home/ericx/Eric/MyPrograms/exam/SysAna"
#alias Sat6="excute_program_in_specific_dir engmain.py /home/ericx/Eric/MyPrograms/exam/English_words"

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

alias set_brightness="sudoedit /sys/class/backlight/intel_backlight/brightness"
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

