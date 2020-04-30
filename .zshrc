# vim:foldmethod=marker
export LANG=en_US.UTF-8

# Antibody {{{1
source <(antibody init)
antibody bundle < ~/.zsh_plugins.txt

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

# Oh-my-zsh {{{1
# Path to your oh-my-zsh installation.
export ZSH="/home/heyrict/.oh-my-zsh"

CASE_SENSITIVE=true

# Uncomment the following line to disable bi-weekly auto-update checks.
DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to display red dots whilst waiting for completion.
#COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

HIST_STAMPS="%Y-%M-%d %H:%m:%s"

plugins=(
    adb
    cargo
    command-not-found
    #django
    colored-man-pages
    docker
    encode64
    fd
    flutter
    git
    node
    npm
    nvm
    pip
    postgres
    python
    ripgrep
    rsync
    rust
    rustup
    taskwarrior
    torrent
    ufw
    virtualenv
    yarn
)

if [ ${TTY:5:3} = "tty" ]; then
    ZSH_THEME="altered-jonathan"
else
    ZSH_THEME="powerlevel10k/powerlevel10k"
fi

source $ZSH/oh-my-zsh.sh

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

# Compilation flags
export ARCHFLAGS="-arch x86_64"

# Lines configured by zsh-newuser-install {{{1
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000

bindkey -v
bindkey "^e" _expand_alias
bindkey '^p' up-history
bindkey '^n' down-history
bindkey '^h' backward-delete-char
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey -M vicmd 'V' edit-command-line
# End of lines configured by zsh-newuser-install

# The following lines were added by compinstall {{{1
#zstyle :compinstall filename '/home/heyrict/.zshrc'
#
#autoload -Uz compinit 
#if [[ -n ${ZDOTDIR:-${HOME}}/.zcompdump(#qN.mh+24) ]]; then
#	compinit;
#else
#	compinit -C;
#fi;

# End of lines added by compinstall

# Inherited from bash {{{1
## some more ls aliases {{{2
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
## "alert" alias for long running commands {{{2
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

## Alias definitions {{{2
if [ -f ~/.bash_aliases ]; then
    source ~/.bash_aliases
fi
# Enviroment {{{1
## Mapping {{{2
typeset -U path
export -TU INFOPATH infopath
export -TU CLASSPATH classpath

path=('/usr/local/bin' '/usr/bin' $path)
manpath=('/usr/local/man' '/usr/share/man' $manpath)

## Texlive {{{2
manpath+=/usr/local/texlive/2019/texmf-dist/doc/man
infopath+=/usr/local/texlive/2019/texmf-dist/doc/info
path+=/usr/local/texlive/2019/bin/x86_64-linux
## Nvm {{{2
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
## Yarn {{{2
path+=$HOME/.yarn/bin
## Java {{{2
export JAVA_HOME=/usr/lib/jvm/java-12-openjdk-amd64
classpath=(. $JAVA_HOME/lib/dt.jar $JAVA_HOME/lib/tools.jar)
path=($JAVA_HOME/bin $JAVA_HOME/jre/bin $path)
## Android {{{2
export ANDROID_HOME="$HOME/Android"
export ANDROIDSDK="$HOME/Android"
export APP_ANDROID_SDK_PATH="$HOME/Android"

## Rust {{{2
export RUSTUP_DIST_SERVER=https://mirrors.ustc.edu.cn/rust-static
export RUSTUP_UPDATE_ROOT=https://mirrors.ustc.edu.cn/rust-static/rustup
export RUST_SRC_PATH=/home/heyrict/.rustup/toolchains/nightly-x86_64-unknown-linux-gnu/lib/rustlib/src/rust/src
path+=$HOME/.cargo/bin
## Flutter {{{2
#export PUB_HOSTED_URL=https://pub.flutter-io.cn
#export FLUTTER_STORAGE_BASE_URL=https://storage.flutter-io.cn
export PUB_HOSTED_URL="https://mirrors.tuna.tsinghua.edu.cn/dart-pub/"
export FLUTTER_STORAGE_BASE_URL="https://mirrors.tuna.tsinghua.edu.cn/flutter"
path+=$HOME/Flutter/bin
path+=$HOME/Flutter/bin/cache/dart-sdk/bin
## NNN {{{2

# Book marks
# - w: working directory
# - c: notes for clinical medicine
# - m: Multimedia
# - u: Mount point
# - t: /tmp
export NNN_BMS="w:~/Eric/MyPrograms;c:~/pandoc_markdown/markdown/CliMed;m:/media/heyrict/LENOVO/Eric/mov;u:/media/heyrict;t:/tmp"

export NNN_COLORS='5234'
export NNN_ARCHIVE="\\.(7z|bz2|gz|tar|tgz|zip)$"
export NNN_IDLE_TIMEOUT=180

# Plugins
# - o: Open file found with fzf
# - p: Play this music in mocp server
# - d: Show diffs between two files
# - c: CD into directory found with fzf
# - s: Organize
# - b: Page the file with bat
export NNN_PLUG='o:fzopen;p:-mocplay;d:diffs;k:-chksum;c:fzcd;z:fzz;s:organize;b:-_bat $nnn'
## Custom {{{2
export TASKRC="~/.taskrc"

path=(
    $path
    $HOME/Eric/MyPrograms/bin
    $HOME/Eric/Program_Files/bin
    $HOME/Eric/Program_Files/java-jars
    $HOME/Android/platform-tools
)

# Other configs {{{1
## History {{{2
export HIST_EXPIRE_DUPS_FIRST=true
export APPEND_HISTORY=true
export HIST_REDUCE_BLANKS=true
export HIST_IGNORE_SPACE=true
export HIST_SAVE_NO_DUPS=true

## Python {{{2
source ~/pyenv/env/bin/activate
export HASURA_GRAPHQL_ADMIN_SECRET="CINDYTHINK_HASURA_ADMIN_SECRET"

## Change ls colors {{{2
export LS_COLORS="$LS_COLORS:ow=1;36"

## Navi {{{2
export NAVI_PATH=~/.config/navi/custom/

# Starship for zsh {{{1
#case "$TERM" in
#    xterm-color|*-256color) eval "$(starship init zsh)";;
#esac

# Fuzzy finder {{{1
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Powerlevel10k {{{1
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Navi {{{1
[ -x `command -v navi` ] && source <(navi widget zsh)
