
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
export GTK2_RC_FILES="${XDG_CONFIG_HOME:-$HOME/.config}/gtk-2.0/gtkrc-2.0"
export ZDOTDIR="${XDG_CONFIG_HOME:-$HOME/.config}/zsh"

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
