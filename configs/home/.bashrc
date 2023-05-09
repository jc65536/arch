#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias la='ls -a'
alias ll='ls -al'
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -I'

alias dl-music='yt-dlp --cookies-from-browser firefox -x --audio-quality 0'
alias ged='gnome-text-editor'

PS1='[\u@\h \W]\$ '

shopt -s histverify

. /usr/share/git/completion/git-completion.bash

. "$HOME/.cargo/env"

[ -f "/home/jason/.ghcup/env" ] && source "/home/jason/.ghcup/env" # ghcup-env
