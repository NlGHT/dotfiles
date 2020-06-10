#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

PS1='[\u@\h \W]\$ '

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

# Enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# Exports
export EDITOR=nvim
export CLICOLOR=1
export TERM=alacritty

# Coloured GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# Some ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias ld='ls -d .*/ */'
alias mv='mv -i'
alias rm='rm -i'

# Alias definitions.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

neofetch --ascii_distro Arch_small --color_blocks off --disable uptime resolution cpu gpu de wm theme icons model term

