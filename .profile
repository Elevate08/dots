export CARGO_HOME="$HOME/.config/rust/cargo"
export RUSTUP_HOME="$HOME/.config/rust/rustup"

export PATH="$PATH:$HOME/.local/bin:$HOME/.local/bin/statusbar:$CARGO_HOME"

export EDITOR="vim"
export TERMINAL="st"
export BROWSER="vivaldi-stable"
export READER="zathura"
export STATUSBAR="i3blocks"

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

alias vim=nvim

export PATH="$HOME/.cargo/bin:$PATH"

# Allow aliases to pass through sudo command
alias sudo='sudo '
