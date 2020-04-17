export PATH="$PATH:$(du "$HOME/.local/bin/" | cut -f2 | tr '\n' ':' | sed 's/:*$//')"

export EDITOR="vim"
export TERMINAL="st"
export BROWSER="vivaldi-stable"
export READER="zathura"
export STATUSBAR="$(cut -d= -f 2 ~/.dmrc | tail -n 1)blocks"

export GTK2_RC_FILE="$HOME/.config/gtk-2.0/gtkrc-2.0"
export LESSHISTFILE="-"
export WGETRC="$HOME/.config/wget/wgetrc"
export INPUTRC="$HOME/.config/inputrc"
export ZDOTDIR="$HOME/.config/zsh"
export PASSWORD_STORE_DIR="$HOME/.local/share/password-store"

export SUDO_ASKPASS="$HOME/.local/bin/dmenupass"
export LESS=-R

[ ! -f ~/.config/shortcutrc ] && shortcuts >/dev/null 2>&1

[ "$(tty)" = "/dev/tty" ] && ! pgrep -x Xorg >/dev/null && exec startx
