# vim:foldmethod=marker ts=2 sw=2

if [ "$SSH_CONNECTION" ]; then
  SSH_SESSION=$(echo "$SSH_CONNECTION" | cut -d' ' -f1 | base64)
fi

# Language and IME {{{1
export LANG=en_US.UTF-8
export XMODIFIERS="@im=fcitx"

export GTK_IM_MODULE="fcitx"
export QT_IM_MODULE="fcitx"
export QT_IM_MODULES="wayland;fcitx"
export SDL_IM_MODULE="fcitx"

# The following lines were added by compinstall {{{1
fpath=(${ZDOTDIR:-$HOME/.zsh}/completion $fpath)

zstyle :compinstall filename '/home/heyrict/.zshrc'
zstyle ':completion:*' menu select

autoload -Uz compinit
compinit

# End of lines added by compinstall

# Custom completions with --help {{{1
helpcomp_bins=(
    ctfetch
    dust
    gotop
    miniserve
    xsv
    zathura
    bat
)
compdef _gnu_generic $helpcomp_bins
compdef nvim=vim

# Completion styles {{{1
zstyle ':completion:*' auto-description yes
zstyle ':completion:*:descriptions' format "%U%B%d%b%u"
zstyle ':completion:*:messages' format "%F{green}%d%f"
zstyle ':completion:*' verbose yes
zstyle ':completion:*' group-name ''

# Antibody {{{1
export ANTIBODY_HOME=~/.antibody
source <(antibody init)
antibody bundle < ~/.zsh/.zsh_plugins.txt

#if [ ! "${TTY:5:3}" = "tty" ]; then
#    antibody bundle romkatv/powerlevel10k
#fi

# Oh-my-zsh {{{1
## Path to your oh-my-zsh installation.
#export ZSH="/home/heyrict/.oh-my-zsh"
#
#CASE_SENSITIVE=true
#
## Uncomment the following line to disable bi-weekly auto-update checks.
#DISABLE_AUTO_UPDATE="true"
#
## Uncomment the following line to display red dots whilst waiting for completion.
##COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

HIST_STAMPS="%Y-%M-%d %H:%m:%s"

#plugins=(
#    adb
#    cargo
#    command-not-found
#    #django
#    colored-man-pages
#    docker
#    encode64
#    fd
#    flutter
#    git
#    node
#    npm
#    nvm
#    pip
#    postgres
#    python
#    ripgrep
#    rsync
#    rust
#    rustup
#    taskwarrior
#    torrent
#    ufw
#    virtualenv
#    yarn
#)
#
#if [ ${TTY:5:3} = "tty" ]; then
#    ZSH_THEME="altered-jonathan"
#else
#    ZSH_THEME="powerlevel10k/powerlevel10k"
#fi
#
#source $ZSH/oh-my-zsh.sh

# Preferred editor for local and remote sessions
if [ $SSH_CONNECTION ]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

# Compilation flags
export ARCHFLAGS="-arch x86_64"

# History {{{1
if [ $SSH_CONNECTION ]; then
  HISTFILE=~/.histfile_$SSH_SESSION
else
  HISTFILE=~/.histfile
fi
HISTSIZE=1000
SAVEHIST=1000
setopt EXTENDED_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt APPEND_HISTORY
setopt HIST_REDUCE_BLANKS
setopt HIST_IGNORE_SPACE
setopt HIST_IGNORE_DUPS
setopt HIST_SAVE_NO_DUPS

# Vim key binding {{{1
bindkey -v
bindkey "^e" _expand_alias
bindkey '^p' up-history
bindkey '^n' down-history
bindkey '^h' backward-delete-char
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey -M vicmd 'V' edit-command-line
# End of lines configured by zsh-newuser-install

# Ported from bash {{{1
## colored prompts {{{2
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

## some more ls aliases {{{2
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -F'
## "alert" alias for long running commands {{{2
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

## Alias definitions {{{2
if [ -f ~/.bash_aliases ]; then
    source ~/.bash_aliases
fi
# Enviroment {{{1
## XDG Directories {{{2
export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache
export XDG_DATA_HOME=$HOME/.local/share
export XDG_STATE_HOME=$HOME/.local/state

## Mapping {{{2
typeset -U path
export -TU INFOPATH infopath
export -TU CLASSPATH classpath

path=('/usr/local/bin' '/usr/bin' $path)
manpath=('/usr/local/man' '/usr/share/man' $manpath)

## Texlive {{{2
manpath+=/usr/local/texlive/2024/texmf-dist/doc/man
infopath+=/usr/local/texlive/2024/texmf-dist/doc/info
path=(/usr/local/texlive/2024/bin/x86_64-linux $path)

## XWayland and Wayland related {{{2
export ANKI_WAYLAND=1
export MOZ_ENABLE_WAYLAND=1
export WINIT_X11_SCALE_FACTOR=1 # No upscaling in XWayland

## Nvm {{{2
export NVM_DIR="$HOME/.nvm"
source /usr/share/nvm/init-nvm.sh
path=($path $HOME/.bun/bin)

## Yarn {{{2
path+=$HOME/.yarn/bin
## Java {{{2
export JAVA_HOME=/usr/lib/jvm/java-21-openjdk
classpath=(. $JAVA_HOME/lib/dt.jar $JAVA_HOME/lib/tools.jar)
path=($JAVA_HOME/bin $JAVA_HOME/jre/bin $path)
## Android {{{2
export ANDROID_SDK_ROOT="/opt/android-sdk"
export ANDROID_HOME="/opt/android-sdk"
path+=$ANDROID_SDK_ROOT/platform-tools

## Rust {{{2
export RUSTUP_DIST_SERVER=https://mirrors.ustc.edu.cn/rust-static
export RUSTUP_UPDATE_ROOT=https://mirrors.ustc.edu.cn/rust-static/rustup
export RUST_SRC_PATH=/home/heyrict/.rustup/toolchains/nightly-x86_64-unknown-linux-gnu/lib/rustlib/src/rust/src
path+=$HOME/.cargo/bin
## Go {{{2
#go env -w GO111MODULE=on
#go env -w GOPROXY=https://goproxy.cn,direct

## Flutter {{{2
#export PUB_HOSTED_URL=https://pub.flutter-io.cn
#export FLUTTER_STORAGE_BASE_URL=https://storage.flutter-io.cn
export PUB_HOSTED_URL="https://mirrors.tuna.tsinghua.edu.cn/dart-pub/"
export FLUTTER_STORAGE_BASE_URL="https://mirrors.tuna.tsinghua.edu.cn/flutter"
path+=$HOME/Flutter/bin
path+=$HOME/Flutter/bin/cache/dart-sdk/bin
## GPG {{{2
export GPG_TTY=$(tty)

## Neovide {{{2
export NEOVIDE_MULTIGRID=1

## Zoxide {{{2
export _ZO_EXCLUDE_DIRS=$HOME:$HOME/Private/:/tmp*

## Lua {{{2
path=($HOME/.luarocks/bin $path)

## Custom {{{2
export TASKRC="~/.taskrc"

path=(
    $path
    $HOME/MyPrograms/bin
    $HOME/Programs/bin
    $HOME/Programs/Slicer-4.11.0-2020-04-30-linux-amd64/bin
    $HOME/Android/platform-tools
)

# Prevent `less` from storing and regenerate history file
export LESSHISTFILE=/dev/null


# Other configs {{{1
## Vulkan {{{2

# Use RADV vulkan driver
export AMD_VULKAN_ICD=RADV

## Zsh {{{2
unsetopt beep

## Python {{{2
if [ ! "${TTY:5:3}" = "tty" ]; then
    # Load venv only on pseudo-tty
    source ~/pyenv/env/bin/activate
fi
export HASURA_GRAPHQL_ADMIN_SECRET="CINDYTHINK_HASURA_ADMIN_SECRET"

## Change ls colors {{{2
export LS_COLORS="$LS_COLORS:ow=1;36"

## Navi {{{2
export NAVI_PATH=~/.config/navi/custom

## Veloren {{{2
export VELOREN_ASSETS=/usr/share/veloren

## Qt {{{2
export QT_QPA_PLATFORMTHEME=qt5ct

# Network related {{{1
export CURL_SSL_BACKEND=rustls

# Starship for zsh {{{1
case "$TERM" in
    alacritty|xterm-color|*-256color) unset STARSHIP_CONFIG;
      eval "$(starship init zsh)";;
    *) export STARSHIP_CONFIG=/home/heyrict/.config/starship-plain.toml;
      eval "$(starship init zsh)";;
esac

# Fuzzy finder {{{1
[ -f ~/.zsh/.fzf.zsh ] && source ~/.zsh/.fzf.zsh

# Powerlevel10k {{{1
# To customize prompt, run `p10k configure` or edit ~/.zsh/.p10k.zsh.
[[ ! -f ~/.zsh/.p10k.zsh ]] || source ~/.zsh/.p10k.zsh

# Navi {{{1
#Change shortcut to '^y' to avoid conflicts
[ -x `command -v navi` ] && source <(navi widget zsh)

# NNN {{{1

# Book marks
# - w: working directory
# - c: notes for clinical medicine
# - m: Multimedia
# - u: Mount point
# - t: /tmp
export NNN_BMS="w:~/MyPrograms;c:~/pandoc_markdown/CliMed;m:/mnt/windows;u:/run/media;t:/tmp"

# Light theme
export NNN_COLORS='5234'
export NNN_FCOLORS='04030c020001090e050ddc06'
export NNN_ARCHIVE="\\.(7z|bz2|gz|tar|tgz|zip|zst)$"
export NNN_IDLE_TIMEOUT=180

# Plugins
# - o: Open file found with fzf
# - p: View photos in this folder
# - P: View photos in this folder in numeric order
# - d: Show diffs between two files
# - c: CD into directory found with fzf
# - s: Organize
# - b: Page the file with bat
export NNN_PLUG='o:fzopen;p:-!feh -Z.*;P:-!feh -Z. `ls|sort -n`*;d:diffs;k:!chksum;c:fzcd;z:fzz;S:organize;b:-!bat "$nnn";s:croc'

# Start window managers automatically {{{1
if [ -z $DISPLAY ] && [ "$(tty)" = "/dev/tty1" ]; then
  exec sway
elif [ -z $DISPLAY ] && [ "$(tty)" = "/dev/tty2" ]; then
  exec startx
fi

# Countdown in alacritty
#if [ "$TERM" = "alacritty" ]; then
#  local TARGET=`date -d "March 13" +%j`
#  local TODAY=`date +%j`
#  local DAYS=$(($TARGET - $TODAY))
#  local COUNTDOWN="\
#   \e[1m== 倒计时 ==\e[0m
#
#距离复试还有约 \e[1;31m$DAYS\e[0m 天
#"
#
#  case $DAYS in
#    [0-9]*)
#      echo
#      echo $COUNTDOWN | ponythink -b unicode -f $HOME/.config/ponysay/eevee.pony;;
#  esac
#fi
