#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

stty -ixon # Disable ^S and ^Q which freezes term
shopt -s autocd # Allows auto cd'ing into directory by just typing directory name

export PS1='[\u@\h \W]\$ '

# Enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls -hN --color=auto --group-directories-first'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# Exports
export EDITOR=vim
export CLICOLOR=1
export TERM=alacritty

# Coloured GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# Some ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias ld='ls -d .*/ */'
alias mv='mv -i' # Ask to confirm
alias rm='rm -i' # Ask to confirm

# Alias definitions.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# Run a nice comfy neofetch :D
neofetch --ascii_distro Arch_small --color_blocks off --disable uptime resolution cpu gpu de wm theme icons model term
