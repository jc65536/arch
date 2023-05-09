PATH=$PATH:~/.local/bin:~/bin
export MOZ_ENABLE_WAYLAND=1
EDITOR=vim
. "$HOME/.cargo/env"
[ -f "/home/jason/.ghcup/env" ] && source "/home/jason/.ghcup/env" # ghcup-env
