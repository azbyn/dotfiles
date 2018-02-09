#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

#alias sudo='sudo -E'
#alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '

export VISUAL="nvim"
export EDITOR="nvim"
#PATH=$PATH:~/bin

export BASE16_SHELL_SET_BACKGROUND=false
if [[ "$TERM" != *linux* ]]; then
	sh $HOME/.colors/shell
	exec fish
fi
