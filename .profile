
#     /\            | |     | |    (_)
#    /  \   _ __ ___| |__   | |     _ _ __  _   ___  __
#   / /\ \ | '__/ __| '_ \  | |    | | '_ \| | | \ \/ /
#  / ____ \| | | (__| | | | | |____| | | | | |_| |>  <
# /_/    \_\_|  \___|_| |_| |______|_|_| |_|\__,_/_/\_\

#
# ~/.profile
#

export TERM="alacritty"
export EDITOR="nvim"
export BROWSER="brave"
export READER="zathura"

# Set PATH so it includes user's bash scripts if it exists
if [ -d "$HOME/.bin" ] ; then
    PATH="$HOME/.bin:$PATH"
fi

# Set PATH so it includes user's EMACS scripts if it exists (DOOM EMACS doom command)
if [ -d "$HOME/.emacs.d/bin" ] ; then
        PATH="$HOME/.emacs.d/bin:$PATH"
fi

# Set PATH so it includes user's bash scripts in .local if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

if [ -d "$HOME/Android/Sdk/tools" ] ; then
    PATH="$HOME/Android/Sdk/tools:$PATH"
fi

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"

export GTK_RC_FILES="$XDG_CONFIG_HOME"/gtk-1.0/gtkrc
export GTK2_RC_FILES="${XDG_CONFIG_HOME:-$HOME/.config}/gtk-2.0/gtkrc-2.0"
export ZDOTDIR="${XDG_CONFIG_HOME:-$HOME/.config}/zsh"
export LESSHISTFILE="-"
export WGETRC="${XDG_CONFIG_HOME:-$HOME/.config}/wget/wgetrc"
export INPUTRC="${XDG_CONFIG_HOME:-$HOME/.config}/inputrc"
export GOPATH="${XDG_DATA_HOME:-$HOME/.local/share}/go"
export HISTFILE="${XDG_DATA_HOME:-$HOME/.local/share}/history"

export NPM_CONFIG_USERCONFIG="${XDG_CONFIG_HOME:-$HOME/.config}/npm/npmrc"
export NVM_DIR="${XDG_DATA_HOME:-$HOME/.local/share}/nvm"
export GRADLE_USER_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/gradle"

# __    _          _       .    ,
# |\   |  `   ___. /      _/_   /   ____
# | \  |  | .'   ` |,---.  |       (
# |  \ |  | |    | |'   `  |       `--.
# |   \|  /  `---| /    |  \__/   \___.'
#            \___/

#     .                 _           .
#    /|    .___    ___  /           /     ` , __   ,   . _  .-
#   /  \   /   \ .'   ` |,---.      |     | |'  `. |   |  \,'
#  /---'\  |   ' |      |'   `      |     | |    | |   |  /\
#,'      \ /      `._.' /    |      /---/ / /    | `._/| /  \
