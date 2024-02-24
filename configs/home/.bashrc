#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

[[ -f ~/.bash_profile ]] && . ~/.bash_profile

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

shell_time=$(date "+%s")

if [ -f /tmp/last-shell-time ]; then
    last_shell_time=$(cat /tmp/last-shell-time)
else
    last_shell_time=0
fi

if [[ $shell_time -gt $((last_shell_time + 1200)) ]]; then
    random-quote
fi

echo $shell_time > /tmp/last-shell-time
