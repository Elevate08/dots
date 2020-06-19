# Enable colors and change prompt:
autoload -U colors && colors        #  Load colors
PS1="[%{$fg[yellow]%}%n%B%{$fg[white]%}@%{$reset_color%}%M %{$fg[yellow]%}%~%{$reset_color%}]$%b "

setopt autocd           # Automatically cd into typed directory.
stty stop undef         # Disable ctrl-s to freeze terminal.

# History configurations
HISTFILE=~/.cache/zsh/history
HISTSIZE=10000
SAVEHIST=10000

setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_FIND_NO_DUPS

# Load aliases and shortcuts if existent.
# [ -f "${XDG_CONFIG_HOME:-$HOME/.config}/shortcutrc" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/shortcutrc"
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/aliasrc" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/aliasrc"
# [ -f "${XDG_CONFIG_HOME:-$HOME/.config}/zshnameddirrc" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/zshnameddirrc"

# Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)           # Include hidden files.

# vi mode
bindkey -v
export KEYTIMEOUT=1

# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

# Change cursor shape for different vi modes.
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
     [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q'
  elif [[ ${KEYMAP} == main ]] ||
       [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} = '' ]] ||
       [[ $1 = 'beam' ]]; then
    echo -ne '\e[5 q'
  fi
}
zle -N zle-keymap-select
zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[5 q"
}
zle -N zle-line-init
echo -ne '\e[5 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.

# Use lf to switch directories and bind it to ctrl-o
lfcd () {
    tmp="$(mktemp)"
    lf -last-dir-path="$tmp" "$@"
    if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        rm -f "$tmp" >/dev/null
        [ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"
    fi
}
bindkey -s '^o' 'lfcd\n'

bindkey -s '^a' 'bc -l\n'

bindkey -s '^f' 'cd "$(dirname "$(fzf)")"\n'

bindkey '^[[P' delete-char

# Edit line in vim with ctrl-e:
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line

# Load Suggestions for Auto-Complete
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# Ctrl+R Reverse Search
bindkey '^R' history-incremental-search-backward

# Allow ZSH to rehash packages when installed / updated
# shcache_time="$(date +%s%N)"

# autoload -Uz add-zsh-hook

# rehash_precmd() {
#   if [[ -a /var/cache/zsh/pacman ]]; then
#     local paccache_time="$(date -r /var/cache/zsh/pacman +%s%N)"
#     if (( zshcache_time < paccache_time )); then
#       rehash
#       zshcache_time="$paccache_time"
#     fi
#   fi
# }

# add-zsh-hook -Uz precmd rehash_precmd

## Up/Down History Search
#autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
#zle -N up-line-or-beginning-search
#zle -N down-line-or-beginning-search
#
#[[ -n "${key[Up]}"   ]] && bindkey -- "${key[Up]}"   up-line-or-beginning-search
#[[ -n "${key[Down]}" ]] && bindkey -- "${key[Down]}" down-line-or-beginning-search

#### Keybindings ###
########################################
# create a zkbd compatible hash;
# to add other keys to this hash, see: man 5 terminfo
#typeset -g -A key
#
#key[Home]="${terminfo[khome]}"
#key[End]="${terminfo[kend]}"
#key[Insert]="${terminfo[kich1]}"
#key[Backspace]="${terminfo[kbs]}"
#key[Delete]="${terminfo[kdch1]}"
#key[Up]="${terminfo[kcuu1]}"
#key[Down]="${terminfo[kcud1]}"
#key[Left]="${terminfo[kcub1]}"
#key[Right]="${terminfo[kcuf1]}"
#key[PageUp]="${terminfo[kpp]}"
#key[PageDown]="${terminfo[knp]}"
#key[Shift-Tab]="${terminfo[kcbt]}"
#
## setup key accordingly
#[[ -n "${key[Home]}"      ]] && bindkey -- "${key[Home]}"      beginning-of-line
#[[ -n "${key[End]}"       ]] && bindkey -- "${key[End]}"       end-of-line
#[[ -n "${key[Insert]}"    ]] && bindkey -- "${key[Insert]}"    overwrite-mode
#[[ -n "${key[Backspace]}" ]] && bindkey -- "${key[Backspace]}" backward-delete-char
#[[ -n "${key[Delete]}"    ]] && bindkey -- "${key[Delete]}"    delete-char
#[[ -n "${key[Up]}"        ]] && bindkey -- "${key[Up]}"        up-line-or-history
#[[ -n "${key[Down]}"      ]] && bindkey -- "${key[Down]}"      down-line-or-history
#[[ -n "${key[Left]}"      ]] && bindkey -- "${key[Left]}"      backward-char
#[[ -n "${key[Right]}"     ]] && bindkey -- "${key[Right]}"     forward-char
#[[ -n "${key[PageUp]}"    ]] && bindkey -- "${key[PageUp]}"    beginning-of-buffer-or-history
#[[ -n "${key[PageDown]}"  ]] && bindkey -- "${key[PageDown]}"  end-of-buffer-or-history
#[[ -n "${key[Shift-Tab]}" ]] && bindkey -- "${key[Shift-Tab]}" reverse-menu-complete
#
## Finally, make sure the terminal is in application mode, when zle is
## active. Only then are the values from $terminfo valid.
#if (( ${+terminfo[smkx]} && ${+terminfo[rmkx]} )); then
#	autoload -Uz add-zle-hook-widget
#	function zle_application_mode_start { echoti smkx }
#	function zle_application_mode_stop { echoti rmkx }
#	add-zle-hook-widget -Uz zle-line-init zle_application_mode_start
#	add-zle-hook-widget -Uz zle-line-finish zle_application_mode_stop
#fi
#
## Using Ctrl+Arrow to move forward/backward a word
#key[Control-Left]="${terminfo[kLFT5]}"
#key[Control-Right]="${terminfo[kRIT5]}"
#
#[[ -n "${key[Control-Left]}"  ]] && bindkey -- "${key[Control-Left]}"  backward-word
#[[ -n "${key[Control-Right]}" ]] && bindkey -- "${key[Control-Right]}" forward-word
#
########################################################################################
## The following lines were added by compinstall
#
#zstyle ':completion:*' completer _expand _complete _ignored _approximate
#zstyle ':completion:*' group-name ''
#zstyle ':completion:*' list-colors ''
#zstyle ':completion:*' matcher-list '' 'r:|[._-]=** r:|=**'
#zstyle ':completion:*' max-errors 2
#zstyle :compinstall filename '/home/elevate/.config/zsh/.zshrc'
#
#autoload -Uz compinit
#compinit
## End of lines added by compinstall
## Lines configured by zsh-newuser-install
#
## End of lines configured by zsh-newuser-install
########################################################################################


alias sudo='sudo '
alias vim=nvim

export PATH="$HOME/.cargo/bin:$PATH"

