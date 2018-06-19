if not status --is-interactive
	exit 1
end
fish_default_key_bindings
#fish_vi_key_bindings
#fish_hybrid_key_bindings

set -x RANGER_LOAD_DEFAULT_RC FALSE
set -x DC_BASE ldc

set -g theme_display_date no
set -g theme_nerd_fonts yes
set -g theme_display_vi no
set -g theme_show_exit_status yes
set -g theme_color_scheme terminal2
set -g theme_display_cmd_duration no
set -g theme_project_dir_length 3
set -g theme_title_use_abbreviated_path no

alias apacman="apacman --noedit"
alias apacmann="apacman --noconfirm"

alias g="cd"
alias gE="cd ~/.emacs.d/"
alias gV="cd ~/.config/nvim/"
alias gA="cd ~/.config/awesome/"
alias gF="cd ~/.config/fish/"
alias gR="cd ~/.config/ranger/"
alias gC="cd ~/.config/"
alias gCl="cd ~/.config/colors/"
alias gQ="cd ~/.config/qutebrowser/"
alias gR="cd ~/.config/ranger/"
alias gD="cd ~/Downloads/"
alias gDf="cd ~/dotfiles/"
alias gG="cd ~/Git/"
alias gM="cd ~/Music/"
alias gP="cd ~/Projects/"
alias gB="cd ~/bin/"
alias gW="cd /mnt/windows/"
alias gH="cd /mnt/hdd/"

alias rh="r --cmd='set show_hidden true'"
alias rV="r ~/.config/nvim/"
alias rA="r ~/.config/awesome/"
alias rF="r ~/.config/fish/"
alias rR="r ~/.config/ranger/"
alias rC="r ~/.config/"
alias rCl="r ~/.config/colors/"
alias rD="r ~/Downloads/"
alias rDf="r --cmd='set show_hidden true' ~/dotfiles/"
alias rG="r ~/Git/"
alias rM="r ~/Music/"
alias rP="r ~/Projects/"
alias rB="r ~/bin/"
alias rW="r /mnt/windows/"
alias rH="r /mnt/hdd/"
alias rQ="r ~/.config/qutebrowser/"

alias eB="e ~/.bashrc"
alias eX="e ~/.Xresources"
alias eR="e ~/.config/ranger/"
alias eRR="e ~/.config/ranger/rc.conf"
alias eQ="e ~/.config/qutebrowser/config.py"
alias eV="e ~/.config/nvim/init.vim"
alias eVS="e /usr/share/vim/vim80/syntax/"
alias eDf="e ~/dotfiles/"
alias eE="e ~/.emacs.d/"

alias eG2="e ~/.gtkrc-2.0"
alias eG3="e ~/.config/gtk-3.0/settings.ini"


alias eF="e ~/.config/fish/config.fish"
alias eFF="e ~/.config/fish/functions/"
alias eFFP="e ~/.config/fish/functions/fish_prompt.fish"
alias eFFG="e ~/.config/fish/functions/fish_greeting.fish"

alias eC="e ~/.config/colors/colors"
alias eCT="e ~/.config/colors/templates/"
alias eCTC="e ~/.config/colors/templates/colortest.mustache"
alias eCTS="e ~/.config/colors/templates/shell.mustache"
alias eCTG="e ~/.config/colors/templates/gtk2.mustache"
alias eCTV="e ~/.config/colors/templates/vim.mustache"
alias eCTX="e ~/.config/colors/templates/xresources.mustache"

alias eA="e ~/.config/awesome/"
alias eAD="e ~/.config/awesome/dependencies"
alias eAR="e ~/.config/awesome/rc.lua"
alias eAK="e ~/.config/awesome/keybindings.lua"
alias eAU="e ~/.config/awesome/utils.lua"
alias eAC="e ~/.config/awesome/config.lua"
alias eAT="e ~/.config/awesome/theme.lua"
alias eAS="e ~/.config/awesome/startup_msg"
alias eAL="e ~/.config/awesome/lain/"
alias eALW="e ~/.config/awesome/lain/widget/"
alias eAW="e ~/.config/awesome/widgets/"
alias eAWCl="e ~/.config/awesome/widgets/clock.lua"
alias eAWI="e ~/.config/awesome/widgets/imagebox.lua"
alias eAWV="e ~/.config/awesome/widgets/volume.lua"
alias eAWM="e ~/.config/awesome/widgets/music.lua"
alias eAWR="e ~/.config/awesome/widgets/ram.lua"
alias eAWC="e ~/.config/awesome/widgets/cpu.lua"
alias eAWTm="e ~/.config/awesome/widgets/temp.lua"
alias eAWT="e ~/.config/awesome/widgets/titlebar.lua"
alias eAWL="e ~/.config/awesome/widgets/load.lua"
alias eAWB="e ~/.config/awesome/widgets/battery.lua"
alias eAWN="e ~/.config/awesome/widgets/net.lua"

