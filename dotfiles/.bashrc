#--- Interactive shells only --------------------------------------------------
# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

#--- Colors -------------------------------------------------------------------
# Reset
Color_Off='\033[0m'       # Text Reset
CPref='\001'              # Color prefix
CSuf='\002'               # Color suffix

# Regular Colors
Black='\033[0;30m'        # Black
Red='\033[0;31m'          # Red
Green='\033[0;32m'        # Green
Yellow='\033[0;33m'       # Yellow
Blue='\033[0;34m'         # Blue
Purple='\033[0;35m'       # Purple
Cyan='\033[0;36m'         # Cyan
White='\033[0;37m'        # White

# Bold
BBlack='\033[1;30m'       # Black
BRed='\033[1;31m'         # Red
BGreen='\033[1;32m'       # Green
BYellow='\033[1;33m'      # Yellow
BBlue='\033[1;34m'        # Blue
BPurple='\033[1;35m'      # Purple
BCyan='\033[1;36m'        # Cyan
BWhite='\033[1;37m'       # White

# Underline
UBlack='\033[4;30m'       # Black
URed='\033[4;31m'         # Red
UGreen='\033[4;32m'       # Green
UYellow='\033[4;33m'      # Yellow
UBlue='\033[4;34m'        # Blue
UPurple='\033[4;35m'      # Purple
UCyan='\033[4;36m'        # Cyan
UWhite='\033[4;37m'       # White

# Background
On_Black='\033[40m'       # Black
On_Red='\033[41m'         # Red
On_Green='\033[42m'       # Green
On_Yellow='\033[43m'      # Yellow
On_Blue='\033[44m'        # Blue
On_Purple='\033[45m'      # Purple
On_Cyan='\033[46m'        # Cyan
On_White='\033[47m'       # White

# High Intensity
IBlack='\033[0;90m'       # Black
IRed='\033[0;91m'         # Red
IGreen='\033[0;92m'       # Green
IYellow='\033[0;93m'      # Yellow
IBlue='\033[0;94m'        # Blue
IPurple='\033[0;95m'      # Purple
ICyan='\033[0;96m'        # Cyan
IWhite='\033[0;97m'       # White

# Bold High Intensity
BIBlack='\033[1;90m'      # Black
BIRed='\033[1;91m'        # Red
BIGreen='\033[1;92m'      # Green
BIYellow='\033[1;93m'     # Yellow
BIBlue='\033[1;94m'       # Blue
BIPurple='\033[1;95m'     # Purple
BICyan='\033[1;96m'       # Cyan
BIWhite='\033[1;97m'      # White

# High Intensity backgrounds
On_IBlack='\033[0;100m'   # Black
On_IRed='\033[0;101m'     # Red
On_IGreen='\033[0;102m'   # Green
On_IYellow='\033[0;103m'  # Yellow
On_IBlue='\033[0;104m'    # Blue
On_IPurple='\033[0;105m'  # Purple
On_ICyan='\033[0;106m'    # Cyan
On_IWhite='\033[0;107m'   # White

# Construct color prompt
PS1="\
\$(RET=\$? ; if [[ \$RET -gt 0 ]]; then\
    printf \"\\${CPref}\\${BIRed}\\${CSuf}[\$RET]\"; else \
    printf \"\\${CPref}\\${BIGreen}\\${CSuf}[\$RET]\"; fi) \
\$(if [[ \$USER == "root" ]]; then \
    printf \"\\${CPref}\\${BIRed}\\${CSuf}\"; else\
    printf \"\\${CPref}\\${BGreen}\\${CSuf}\"; fi)\
\u\
\001${BIPurple}\002@\
\001${BGreen}\002\h\
\001${BIWhite}\002:\
\001${BBlue}\002\W\
\$(if [[ \$USER == "root" ]]; then \
    printf \"\\${CPref}\\${BIRed}\\${CSuf}\"; else\
    printf \"\\${CPref}\\${BIPurple}\\${CSuf}\"; fi)\
\$\
\001${Color_Off}\002 "

# Check color prompt
if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
    export PS1=$PS1
else
    export PS1='[\$?] \u@\h:\W\$ '
fi
unset color_prompt force_color_prompt

#--- History ------------------------------------------------------------------
HISTSIZE=9999
HISTFILESIZE=9999
HISTCONTROL=ignoreboth 		# don't put duplicate lines in the history.
shopt -s histappend 		# append to the history file, don't overwrite it
shopt -s checkwinsize 		# update the values of LINES and COLUMNS.

# More fancy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

#--- Aliases ------------------------------------------------------------------
# ls
alias ll='ls -lah --color=auto'
alias la='ls -A --color=auto'
alias l='ls -CF --color=auto'
# apt
alias as='apt search'
alias ai='sudo apt install'
alias uu='sudo apt update && sudo apt upgrade'
alias cmmi='./configure && make && sudo make install'
# git
alias gs='git status'
alias gl='git log'
alias gd='git diff'
alias ga='git add'
alias gaa='git add -A'
alias gac='git add -A ; git commit -m '
alias gc='git commit -m'
alias gpull='git pull'
alias gpush='git push'
# Docker
alias dps="docker ps"
alias di="docker images"
# network
alias ns='sudo netstat -tulpano'
alias v='nvim'
# mps
alias repo="cd ~/mps/repo"
alias disks="cd ~/mps/disks"
alias docs="cd ~/mps/docs"
alias scratch="cd ~/mps/scratch"
alias snippets="cd ~/mps/snippets"
alias vm="cd ~/mps/vm"
alias wsp="cd ~/mps/wsp"

#--- Bash completion ----------------------------------------------------------
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

#--- Environment Variable -----------------------------------------------------
export PATH=$PATH:~/mps/snippets
export EDITOR=nvim
neofetch
