[[ $- != *i* ]] && return

stty -ixon # Disable ^S and ^Q which freezes term

export CLICOLOR=1

unsetopt beep
bindkey -v

# CompInstall
# zstyle :compinstall filename '$ZDOTDIR/.zshrc'
# autoload -Uz compinit
# compinit
# setopt magicequalsubst

# Path to your oh-my-zsh installation.
export ZSH="${XDG_CONFIG_HOME:-$HOME/.config}/ohmyzsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
#
# Official themes
# ZSH_THEME="gallois" Clean and $ (But has long path name)
# ZSH_THEME="mgutz" # Minimal (But has % instead of $)
# ZSH_THEME="minimal" # Minimal (But has % instead of $)

# Themes in custom folder
ZSH_THEME="minimal_improved/minimal_improved" # Ultra Minimal (Bit too much space around $)

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
ZSH_CUSTOM=$ZSH/custom

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
plugins=(
    git
    archlinux
    gitignore
    sudo
    nmap
    vi-mode
)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# Compilation flags
export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
source $ZDOTDIR/.zsh_aliases

# Change cursor on insert/normal mode
# TY to: https://archive.emily.st/2013/05/03/zsh-vi-cursor/
function zle-keymap-select zle-line-init
{
    # Change cursor shape on insert mode
    case $KEYMAP in
        vicmd)      print -n -- "\E]50;CursorShape=0\C-G";;  # Block Cursor
        viins|main) print -n -- "\E]50;CursorShape=1\C-G";;  # Line Cursor
    esac

    zle reset-prompt
    zle -R
}

function zle-line-finish
{
    print -n -- "\E]50;CursorShape=0\C-G"  # block cursor
}

zle -N zle-line-init
zle -N zle-line-finish
zle -N zle-keymap-select

# Comfy Neofetch
if [ "$(pgrep $TERM | wc -l)" -le 1 ]; then
    # Run a nice comfy neofetch if only terminal :D
    which neofetch >/dev/null 2>&1 && \
        neofetch --ascii_distro Arch_small --color_blocks off --disable uptime resolution cpu gpu de wm theme icons model term
fi
