# NVIDIA and Optimus Manager
alias pro='__NV_PRIME_RENDER_OFFLOAD=1 __GLX_VENDOR_LIBRARY_NAME=nvidia'
alias mb='sudo su -c "echo 12 >/sys/class/backlight/intel_backlight/brightness"' # Go to minimum brightness
alias nv='optimus-manager --switch nvidia'
alias intl='optimus-manager --switch intel'

# MongoDB
alias startMongo='sudo systemctl start mongodb.service'
alias stopMongo='sudo systemctl stop mongodb.service'

# Ornamentation
alias weather='curl wttr.in/~aalborg'
alias news='curl getnews.tech'
alias aunews='curl au.getnews.tech'
alias usnews='curl us.getnews.tech'

# All edits
alias editAlacritty='vim ~/.config/alacritty/alacritty.yml'
alias editAwesome='cd ~/.config/awesome/ && vim'
alias editRedshift='vim ~/.config/redshift.conf'
alias editAliases='vim ~/.bash_aliases'
alias editBashRC='vim ~/.bashrc'
alias editVim='vim ~/.vimrc'
alias td='vim ~/ToDoList.txt'
alias editLightDM='sudo vim /etc/lightdm/lightdm.conf'
alias editEMACS='vim ~/.doom.d/init.el'

# Utility
alias update-grub='sudo grub-mkconfig -o /boot/grub/grub.cfg'
alias x='exit'
alias reload='source ~/.bashrc'
alias delOrphans='sudo pacman -Rns $(pacman -Qtdq)' # Remove orphaned packages

# WIFI
alias getRegularWifiPassword='sudo grep psk= /etc/NetworkManager/system-connections/limit56farce59umbra.nmconnection'
alias getLANIP="ip a s wlp2s0 | awk -F '[/ ]+' '/inet / {print $3}'"

# Instant CD's
alias documents='cd ~/Documents'
alias images='cd ~/Pictures'
alias videos='cd ~/Videos'
alias downloads='cd ~/Downloads'
alias uniDocs='cd ~/Documents/Uni/6Sem'
alias uniVideos='cd ~/Videos/Sem6/'

# Dotfiles
alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias seeCommitDiff='config diff --cached origin/master'

# Currency conversion (cconv {amount} {from} {to}) (Country codes must be capital)
cconv() {
    qalc -t $1 $2 to $3
}

# Time functions (Credit: https://superuser.com/a/611582)
function countdown(){
    date1=$((`date +%s` + $1));
    while [ "$date1" -ge `date +%s` ]; do
        echo -ne "$(date -u --date @$(($date1 - `date +%s`)) +%H:%M:%S)\r";
        sleep 0.1
    done
}

function stopwatch(){
    date1=`date +%s`;
    # 24 = q ; 65 = SPACE
    while true; do
        echo -ne "$(date -u --date @$((`date +%s` - $date1)) +%H:%M:%S)\r";
        sleep 0.1
    done
}

# Get all aliases
alias aliases='sed -n -e :a -e "1,4!{P;N;D;};N;ba" ~/.bash_aliases'
alias aliasCommand='tail -n 3 ~/.bash_aliases' # Get the get aliases command
