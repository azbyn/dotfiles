
# basic xorg
PACKAGES := xorg xorg-xinit rxvt-unicode urxvt-perls urxvt-resize-font-git awesome\
         lrexlib-pcre picom lua-yaml lua53-yaml scrot unclutter papirus-icon-theme\
         arc-gtk-theme xclip xdotool

#programs
PACKAGES += emacs htop ranger mpd mpc mpv feh ncmpcpp firefox thunar zathura \
         neofetch keepassxc neovim fish w3m maim qbittorrent
#firefox stuff
PACKAGES += firefox-dark-reader firefox-ublock-origin
#fonts
PACKAGES += nerd-fonts-dejavu-complete ttf-dejavu nerd-fonts-ubuntu-mono \
         ttf-ubuntu-font-family awesome-terminal-fonts ttf-font-awesome ttf-all-the-icons
#programming
PACKAGES += python clang texlive-core texlive-latexextra boost cmake python-virtualenv \
         dub dmd ipython jupyter
#misc
PACKAGES += net-tools fortune-mod lolcat zsh


YOGA_PACKAGES = xournalpp

#of use:
#https://wiki.archlinux.org/index.php/Getty#With_systemd
#https://www.youtube.com/watch?v=Pdmy8dMWitg (fixin popping sound)

main: installPackages linksAndStuff

# only used for arch. manjaro's architect does most of this stuff
.ONESHELL: baseSetup
baseSetup:
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

	# git clone https://aur.archlinux.org/yay.git
	# cd yay
	# makepkg -si

	cd ~/
	git clone git@github.com:azbyn/dotfiles.git

locale:
	sudo cp ~/dotfiles/locale.conf /etc/locale.conf
	sudo cp ~/dotfiles/locale.gen /etc/locale.gen
	sudo locale-gen
 
installPackages:
	yay -S --needed ${PACKAGES}
	sudo luarocks install lrexlib-pcre --lua-version 5.3
	cpan Switch::Plain
	sudo gem install --source http://gems.github.com jamis-fuzzy_file_finder

linkExtra:
	ln -s ~/dotfiles/.Xresources_extra_$(shell hostname) ~/.Xresources_extra

linksAndStuff: linkExtra
	sh ./linkFile.sh .xinitrc
	sh ./linkFile.sh .Xresources
	sh ./linkFile.sh .zshrc
	sh ./linkFile.sh .p10k.zsh
	# sh ./linkFile.sh .bashrc
	# sh ./linkFile.sh .bash_profile
	sh ./linkFile.sh .gdbinit
	sh ./linkFile.sh .gtkrc-2.0
	sh ./linkFile.sh .profile
	sh ./linkFile.sh .xmodmaprc
	git clone git@github.com:azbyn/emacs-config.git ~/.emacs.d
	# sh ./linkFile.sh .emacs.d
	sh ./linkFile.sh .colors
	sh ./linkFile.sh bin
	sudo ln -f ~/dotfiles/ro /usr/share/X11/xkb/symbols/azb || true
	sh ./linkFile.sh .config/awesome
	sh ./linkFile.sh .config/urxvt
	sh ./linkFile.sh .config/colors
	sh ./linkFile.sh .config/fish
	sh ./linkFile.sh .config/rofi
	sh ./linkFile.sh .config/gtk-2.0
	sh ./linkFile.sh .config/gtk-3.0
	mkdir ~/.config/mpd/
	sh ./linkFile.sh .config/mpd/
	sh ./linkFile.sh .config/ncmpcpp
	sh ./linkFile.sh .config/neofetch
	sh ./linkFile.sh .config/nvim
	sh ./linkFile.sh .config/omf
	sh ./linkFile.sh .config/qutebrowser
	sh ./linkFile.sh .config/ranger
	sh ./linkFile.sh .config/feh
	sh ./linkFile.sh .config/keepassxc
	sh ./linkFile.sh .config/picom.conf


dirs:
	mkdir ~/Projects
	mkdir ~/Music
	mkdir ~/Git
	mkdir ~/Downloads
	mkdir -p ~/Pictures/screenshots

.ONESHELL: getProjects
getProjects: makeNcmpcpp
	cd ~/Projects
	git clone https://github.com/azbyn/mrww
	git clone https://github.com/azbyn/screenshotifinator
	git clone https://github.com/azbyn/transliterate
	make -C transliterate


.ONESHELL: makeNcmpcpp
makeNcmpcpp:
	cd ~/Projects
	git clone https://github.com/azbyn/ncmpcpp
	cd ~/Projects/ncmpcpp
	./autogen.sh
	./configure
	make
	sudo make install

disableStuff:
	systemctl disable cronie.service
	systemctl disable bluetooth.service
