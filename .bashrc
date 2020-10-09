#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

stty -ixon # Disable ^S and ^Q which freezes term
shopt -s autocd # Allows auto cd'ing into directory by just typing directory name

export PS1='[\u@\h \W]\$ '

# Exports
export EDITOR=nvim
export CLICOLOR=1
export TERM=alacritty

# Coloured GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# Alias definitions.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

if [ "$(pgrep $TERM | wc -l)" -le 1 ]; then
    # Run a nice comfy neofetch if only terminal :D
    which neofetch >/dev/null 2>&1 && \
        neofetch --ascii_distro Arch_small --color_blocks off --disable uptime resolution cpu gpu de wm theme icons model term
    which fortune >/dev/null 2>&1 && \
        fortune && printf "\n"
fi
