#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

#alias sudo='sudo -E'
#alias ls='ls --color=auto'
#PS1='[\u@\h \W]\$ '



export VISUAL="nvim"
export EDITOR="nvim"
PATH=$PATH:~/bin
PATH="/home/azbyn/perl5/bin${PATH:+:${PATH}}"; export PATH;
PERL5LIB="/home/azbyn/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="/home/azbyn/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"/home/azbyn/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/home/azbyn/perl5"; export PERL_MM_OPT;
export BASE16_SHELL_SET_BACKGROUND=false
export DOTNET_CLI_TELEMETRY_OPTOUT=true


if [[ "$TERM" != *linux* ]]; then
    sh $HOME/.colors/shell
    exec fish
fi

