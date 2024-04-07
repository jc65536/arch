PATH=$PATH:~/.local/bin:~/bin

export MOZ_ENABLE_WAYLAND=1
export EDITOR=nvim
export SSH_AUTH_SOCK=$XDG_RUNTIME_DIR/gcr/ssh

. "$HOME/.cargo/env"
