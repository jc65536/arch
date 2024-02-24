#
# ~/.bash_profile
#

[[ -f ~/.profile ]] && . ~/.profile
. "$HOME/.cargo/env"

# opam configuration
test -r /home/jason/.opam/opam-init/init.sh && . /home/jason/.opam/opam-init/init.sh > /dev/null 2> /dev/null || true
