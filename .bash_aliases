# NVIDIA and Optimus Manager
alias pro='__NV_PRIME_RENDER_OFFLOAD=1 __GLX_VENDOR_LIBRARY_NAME=nvidia'
alias mb='sudo su -c "echo 12 >/sys/class/backlight/intel_backlight/brightness"'
alias nv='optimus-manager --switch nvidia'
alias intl='optimus-manager --switch nvidia'

# MongoDB
alias startMongo='sudo systemctl start mongodb.service'
alias stopMongo='sudo systemctl stop mongodb.service'

# Ornamentation
alias weather='curl wttr.in/~aalborg'
alias news='curl getnews.tech'
alias aunews='curl au.getnews.tech'
alias usnews='curl us.getnews.tech'

# All edits
alias editAlacritty='nvim ~/.config/alacritty/alacritty.yml'
alias editAwesome='cd ~/.config/awesome/ && vim'
alias editRedshift='vim ~/.config/redshift.conf'
alias editAliases='nvim ~/.bash_aliases'
alias editBashRC='nvim ~/.bashrc'
alias editVim='nvim ~/.vimrc'
alias td='nvim ~/ToDoList.txt'

# Utility
alias update-grub='sudo grub-mkconfig -o /boot/grub/grub.cfg'
alias x='exit'
alias reload='source ~/.bashrc'
alias delOrphans='sudo pacman -Rns $(pacman -Qtdq)'

# WIFI
alias getHeleneWifiPassword='sudo grep psk= /etc/NetworkManager/system-connections/limit56farce59umbra.nmconnection'

# Instant CD's
alias documents='cd ~/Documents'
alias images='cd ~/Pictures'
alias videos='cd ~/Videos'
alias downloads='cd ~/Downloads'
alias uniDocs='cd ~/Documents/Uni/6Sem'
alias uniVideos='cd ~/Videos/Sem6/'

# Dotfiles
alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

# Get all aliases
alias aliases='sed -n -e :a -e "1,4!{P;N;D;};N;ba" ~/.bash_aliases'
alias aliasCommand='tail -n 3 ~/.bash_aliases'
