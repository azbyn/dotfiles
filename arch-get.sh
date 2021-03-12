pacman -S base-devel git networkmanager
systemctl enable NetworkManager

useradd azbyn
passwd azbyn
usermod -aG wheel azbyn
visudo
su azbyn
sudo echo "yay"

mkdir /home/azbyn/
chown -R azbyn:azbyn /home/azbyn
mkdir /home/azbyn/Git

#
# git clone https://aur.archlinux.org/yay.git
# cd yay
# makepkg -si


#THE CONFIG

#basic gui
yay -S xorg xorg-xinit rxvt-unicode urxvt-perls urxvt-resize-font-git awesome lrexlib-pcre
#programs
yay -S emacs htop ranger mpd mpc mpv feh ncmpcpp firefox thunar zathura neofetch
yay -S keepassxc
#fonts
yay -S nerd-fonts-dejavu-complete ttf-dejavu
#programming
yay -S python clang


cd ~/
git clone git@github.com:azbyn/dotfiles.git
