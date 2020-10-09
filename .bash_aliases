# Rest in peace Vim <3 I still love you but NeoVim just is needed with all my plugins for performance
alias vim='nvim'
alias v='nvim'
alias suv='sudo nvim'

# Basic shell stuff
# Enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls -hN --color=auto --group-directories-first'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# Some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias ld='ls -d .*/ */'
alias mv='mv -i' # Ask to confirm
alias rm='rm -i' # Ask to confirm

# NVIDIA and Optimus Manager
alias pro='__NV_PRIME_RENDER_OFFLOAD=1 __GLX_VENDOR_LIBRARY_NAME=nvidia'
alias mb='sudo su -c "echo 12 >/sys/class/backlight/intel_backlight/brightness"' # Go to minimum brightness
alias nv='optimus-manager --switch nvidia'
alias intl='optimus-manager --switch intel'
alias gpu='glxinfo | grep renderer'

# MongoDB
alias startMongo='sudo systemctl start mongodb.service'
alias stopMongo='sudo systemctl stop mongodb.service'

# Ornamentation
alias weather='curl wttr.in/~aalborg'
alias news='curl getnews.tech'
alias aunews='curl au.getnews.tech'
alias usnews='curl us.getnews.tech'
alias starwars='telnet towel.blinkenlights.nl'
setDribbblishTheme() {
    # Spotify themeing
    spicetify config current_theme Dribbblish color_scheme "$1" && spicetify apply
}
setupDribblish() {
    # Spotify
    cd "$(dirname "$(spicetify -c)")/Themes/Dribbblish" || return
    cp dribbblish.js ../../Extensions
    spicetify config extensions dribbblish.js
    spicetify config current_theme Dribbblish color_scheme base
    spicetify config inject_css 1 replace_colors 1 overwrite_assets 1
    spicetify apply
}

# All edits
alias eac='nvim ~/.config/alacritty/alacritty.yml'
alias eaw='cd ~/.config/awesome/ && nvim'
alias er='nvim ~/.config/redshift/redshift.conf'
alias eal='nvim ~/.bash_aliases'
alias eb='nvim ~/.bashrc'
alias ev='nvim ~/.vimrc'
alias td='nvim ~/ToDoList.txt'
alias el='sudo nvim /etc/lightdm/lightdm.conf'
alias ee='nvim ~/.doom.d/init.el'

# Utility
alias update-grub='sudo grub-mkconfig -o /boot/grub/grub.cfg'
alias x='exit'
alias reload='source ~/.bashrc'
alias delOrphans='sudo pacman -Rns $(pacman -Qtdq)' # Remove orphaned packages
alias yay!='yay' # YAY!!!!!!!!!
alias pacman='yay'
alias pls='sudo'
alias open='xdg-open'
alias g='git'
alias wdil='history | grep'

# WIFI
alias getRegularWifiPassword='sudo grep psk= /etc/NetworkManager/system-connections/limit56farce59umbra.nmconnection'
alias getLANIP="ip a s wlp2s0 | awk -F '[/ ]+' '/inet / {print $3}'"
alias resetPiSSH='ssh-keygen -R 192.168.87.109'
alias scanwifi='sudo nmap -sS -O'

# System
alias startBluetooth='sudo systemctl start bluetooth.service'

# Instant CD's
alias documents='cd ~/Documents'
alias docs='cd ~/Documents'
alias images='cd ~/Pictures'
alias videos='cd ~/Videos'
alias dl='cd ~/Downloads'
alias uni='cd ~/Documents/Uni/7Sem'
alias lec='cd ~/Documents/Uni/7Sem/Lectures'
alias res='cd ~/Documents/Uni/7Sem/Project/Research'
alias resn='cd ~/Documents/Uni/7Sem/Project/Notes'
alias uniVideos='cd ~/Videos/Sem6/'
alias rscript='cd ~/.config/REAPER/Scripts/Own\ Scripts/Night-REAPER-Scripts'

# Dotfiles
alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias c='config'
alias seeCommitDiff='config diff --cached origin/master'
alias status='config status'

# Currency conversion (cconv {amount} {from} {to}) (Country codes must be capital)
cconv() {
    qalc -t "$1" "$2" to "$3"
}

# Time functions (Credit: https://superuser.com/a/611582)
countdown(){
    date1=$(($(date +%s) + $1));
    while [ "$date1" -ge "$(date +%s)" ]; do
        echo -ne "$(date -u --date @$(($date1 - `date +%s`)) +%H:%M:%S)\r";
        sleep 0.1
    done
}

stopwatch(){
    date1=$(date +%s);
    # 24 = q ; 65 = SPACE
    while true; do
        echo -ne "$(date -u --date @$((`date +%s` - $date1)) +%H:%M:%S)\r";
        sleep 0.1
    done
}

# Get all aliases
alias aliases='head -n -4 ~/.bash_aliases | less'
alias aliasCommand='tail -n 3 ~/.bash_aliases' # Get the get aliases command
