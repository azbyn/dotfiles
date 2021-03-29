# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# USE_POWERLINE="true"

# Source manjaro-zsh-configuration
# if [[ -e /usr/share/zsh/manjaro-zsh-config ]]; then
#   source /usr/share/zsh/manjaro-zsh-config
# fi

[[ ! -f ~/.profile ]] || source ~/.profile


if [ -z "$DISPLAY" ] && [ -n "$XDG_VTNR" ] && [ "$XDG_VTNR" -eq 1 ]; then
    exec startx
elif [[ $TERM == "linux" || $TERM == "dumb" ]]; then
    source /usr/share/zsh/zsh-maia-prompt
else
    sh $HOME/.colors/shell
    source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme
    [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
fi


alias ls="ls --color=auto"
alias sudo="sudo -E"

alias xclip="xclip -selection c"
alias tlmgr='/usr/share/texmf-dist/scripts/texlive/tlmgr.pl --usermode'
alias g="cd"
alias gY="cd ~/.cache/yay"
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
alias gPs="cd ~/Pictures/screenshots/"
alias gL="cd ~/Projects/licenta/"
alias gB="cd ~/bin/"
alias gH="cd /mnt/hdd/"

alias r="ranger"
alias rh="r --cmd='set show_hidden true'"
alias rPs="r ~/Pictures/screenshots/"
alias rY="r ~/.cache/yay"
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
alias rMm="r ~/mnt/"
alias rMM="r ~/mnt/"
alias rP="r ~/Projects/"
alias rB="r ~/bin/"
alias rH="r /mnt/hdd/"
alias rQ="r ~/.config/qutebrowser/"
alias rL="r ~/Projects/licenta/"

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
############
typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[path]='fg=cyan,underline'


ZSH_HIGHLIGHT_STYLES[unknown-token]='fg=red'
ZSH_HIGHLIGHT_STYLES[arg0]='bold'
ZSH_HIGHLIGHT_STYLES[default]='fg=cyan'
ZSH_HIGHLIGHT_STYLES[commandseparator]='fg=yellow'
ZSH_HIGHLIGHT_STYLES[redirection]='fg=yellow'
# command

######

## Options section
setopt correct                                                  # Auto correct mistakes
setopt extendedglob                                             # Extended globbing. Allows using regular expressions with *
setopt nocaseglob                                               # Case insensitive globbing
setopt rcexpandparam                                            # Array expension with parameters
setopt nocheckjobs                                              # Don't warn about running processes when exiting
setopt numericglobsort                                          # Sort filenames numerically when it makes sense
setopt nobeep                                                   # No beep
setopt appendhistory                                            # Immediately append history instead of overwriting
setopt histignorealldups                                        # If a new command is a duplicate, remove the older one
setopt autocd                                                   # if only directory path is entered, cd there.
setopt inc_append_history                                       # save commands are added to the history immediately, otherwise only when shell exits.

# https://linuxhint.com/ls_colors_bash/
LS_COLORS="di=1;34"

zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'       # Case insensitive tab completion
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"         # Colored completion (different colors for dirs/files/etc)

zstyle ':completion:*:commands' list-colors '=*=1;37'
zstyle ':completion:*:parameters'  list-colors '=*=36'
zstyle ':completion:*:options' list-colors '=^(-- *)=34'


zstyle ':completion:*' rehash true                              # automatically find new executables in path
# Speed up completions
zstyle ':completion:*' accept-exact '*(N)'
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache

# zstyle ':completion:*' verbose yes

HISTFILE=~/.zhistory
HISTSIZE=10000
SAVEHIST=10000
WORDCHARS=${WORDCHARS//\/[&.;]}                                 # Don't consider certain characters part of the word


## Keybindings section
bindkey -e
bindkey '^[[7~' beginning-of-line                               # Home key
bindkey '^[[H' beginning-of-line                                # Home key
if [[ "${terminfo[khome]}" != "" ]]; then
  bindkey "${terminfo[khome]}" beginning-of-line                # [Home] - Go to beginning of line
fi
bindkey '^[[8~' end-of-line                                     # End key
bindkey '^[[F' end-of-line                                     # End key
if [[ "${terminfo[kend]}" != "" ]]; then
  bindkey "${terminfo[kend]}" end-of-line                       # [End] - Go to end of line
fi
bindkey '^[[2~' overwrite-mode                                  # Insert key
bindkey '^[[3~' delete-char                                     # Delete key
bindkey '^[[C'  forward-char                                    # Right key
bindkey '^[[D'  backward-char                                   # Left key
bindkey '^[[5~' history-beginning-search-backward               # Page up key
bindkey '^[[6~' history-beginning-search-forward                # Page down key

# Navigate words with ctrl+arrow keys
bindkey '^[Oc' forward-word                                     #
bindkey '^[Od' backward-word                                    #
bindkey '^[[1;5D' backward-word                                 #
bindkey '^[[1;5C' forward-word                                  #
bindkey '^H' backward-kill-word                                 # delete previous word with ctrl+backspace
bindkey '^[[Z' undo                                             # Shift+tab undo last action

# bindkey '^U' undo                                             # Shift+tab undo last action

#my keybindings
setopt noflowcontrol
bindkey '^[u' undo

bindkey '^Q' beginning-of-line
bindkey '^R' end-of-line

bindkey '^A' backward-char
bindkey '^F' forward-char

bindkey '^E' forward-word
bindkey '^W' backward-word

bindkey '^S' history-incremental-search-backward
bindkey '^[s' history-incremental-search-forward

bindkey '^K' kill-line
bindkey '^[k' kill-whole-line

copy-region-as-kill-deactivate-mark () {
  zle copy-region-as-kill
  zle set-mark-command -n -1
  echo -n $CUTBUFFER | xclip
}
zle -N copy-region-as-kill-deactivate-mark

bindkey '^L' copy-region-as-kill-deactivate-mark

get-clipboard() {
  local clip
  clip=$(xclip -sel c -o 2> /dev/null && echo .) || return
  LBUFFER+=${clip%.}
}
zle -N get-clipboard

bindkey '^[i' up-line-or-history
bindkey '^[j' down-line-or-history

bindkey '^[q' up-line-or-history
bindkey '^[r' down-line-or-history

#or yank?
bindkey '^P' get-clipboard



## Alias section
alias cp="cp -i"                                                # Confirm before overwriting something
alias df='df -h'                                                # Human-readable sizes
alias free='free -m'                                            # Show sizes in MB
alias gitu='git add . && git commit && git push'

# Theming section  
autoload -U compinit colors zcalc
compinit -d
colors

# Color man pages
export LESS_TERMCAP_mb=$'\E[01;32m'
export LESS_TERMCAP_md=$'\E[01;32m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;47;34m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;36m'
export LESS=-R


## Plugins section: Enable fish style features
# Use syntax highlighting
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# Use history substring search
source /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh
# bind UP and DOWN arrow keys to history substring search
zmodload zsh/terminfo

# bindkey "$terminfo[kcuu1]" history-substring-search-up
# bindkey "$terminfo[kcud1]" history-substring-search-down

bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# Offer to install missing package if command is not found
if [[ -r /usr/share/zsh/functions/command-not-found.zsh ]]; then
    source /usr/share/zsh/functions/command-not-found.zsh
    export PKGFILE_PROMPT_INSTALL_MISSING=1
fi

# Set terminal window and tab/icon title
#
# usage: title short_tab_title [long_window_title]
#
# See: http://www.faqs.org/docs/Linux-mini/Xterm-Title.html#ss3.1
# Fully supports screen and probably most modern xterm and rxvt
# (In screen, only short_tab_title is used)
function title {
  emulate -L zsh
  setopt prompt_subst

  [[ "$EMACS" == *term* ]] && return

  # if $2 is unset use $1 as default
  # if it is set and empty, leave it as is
  : ${2=$1}

  case "$TERM" in
    xterm*|putty*|rxvt*|konsole*|ansi|mlterm*|alacritty|st*)
      print -Pn "\e]2;${2:q}\a" # set window name
      print -Pn "\e]1;${1:q}\a" # set tab name
      ;;
    screen*|tmux*)
      print -Pn "\ek${1:q}\e\\" # set screen hardstatus
      ;;
    *)
    # Try to use terminfo to set the title
    # If the feature is available set title
    if [[ -n "$terminfo[fsl]" ]] && [[ -n "$terminfo[tsl]" ]]; then
      echoti tsl
      print -Pn "$1"
      echoti fsl
    fi
      ;;
  esac
}

ZSH_THEME_TERM_TAB_TITLE_IDLE="%15<..<%~%<<" #15 char left truncated PWD
ZSH_THEME_TERM_TITLE_IDLE="%n@%m:%~"

# Runs before showing the prompt
function mzc_termsupport_precmd {
  [[ "${DISABLE_AUTO_TITLE:-}" == true ]] && return
  title $ZSH_THEME_TERM_TAB_TITLE_IDLE $ZSH_THEME_TERM_TITLE_IDLE
}

# Runs before executing the command
function mzc_termsupport_preexec {
  [[ "${DISABLE_AUTO_TITLE:-}" == true ]] && return

  emulate -L zsh

  # split command into array of arguments
  local -a cmdargs
  cmdargs=("${(z)2}")
  # if running fg, extract the command from the job description
  if [[ "${cmdargs[1]}" = fg ]]; then
    # get the job id from the first argument passed to the fg command
    local job_id jobspec="${cmdargs[2]#%}"
    # logic based on jobs arguments:
    # http://zsh.sourceforge.net/Doc/Release/Jobs-_0026-Signals.html#Jobs
    # https://www.zsh.org/mla/users/2007/msg00704.html
    case "$jobspec" in
      <->) # %number argument:
        # use the same <number> passed as an argument
        job_id=${jobspec} ;;
      ""|%|+) # empty, %% or %+ argument:
        # use the current job, which appears with a + in $jobstates:
        # suspended:+:5071=suspended (tty output)
        job_id=${(k)jobstates[(r)*:+:*]} ;;
      -) # %- argument:
        # use the previous job, which appears with a - in $jobstates:
        # suspended:-:6493=suspended (signal)
        job_id=${(k)jobstates[(r)*:-:*]} ;;
      [?]*) # %?string argument:
        # use $jobtexts to match for a job whose command *contains* <string>
        job_id=${(k)jobtexts[(r)*${(Q)jobspec}*]} ;;
      *) # %string argument:
        # use $jobtexts to match for a job whose command *starts with* <string>
        job_id=${(k)jobtexts[(r)${(Q)jobspec}*]} ;;
    esac

    # override preexec function arguments with job command
    if [[ -n "${jobtexts[$job_id]}" ]]; then
      1="${jobtexts[$job_id]}"
      2="${jobtexts[$job_id]}"
    fi
  fi

  # cmd name only, or if this is sudo or ssh, the next cmd
  local CMD=${1[(wr)^(*=*|sudo|ssh|mosh|rake|-*)]:gs/%/%%}
  local LINE="${2:gs/%/%%}"

  title '$CMD' '%100>...>$LINE%<<'
}

autoload -U add-zsh-hook
add-zsh-hook precmd mzc_termsupport_precmd
add-zsh-hook preexec mzc_termsupport_preexec

