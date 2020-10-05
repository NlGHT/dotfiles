#
# ~/.profile
#

export TERM=alacritty
export EDITOR=vim

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
