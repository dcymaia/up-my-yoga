#
# ~/.bashrc
#


HOME='/home/danilo'
CHARSET='UTF-8'

export LANG=en_US.$CHARSET
export LC_ALL=en_US.$CHARSET
export MM_CHARSET=$CHARSET

# history
export HISTCONTROL=ignorespace
export HISTTIMEFORMAT="%d/%m/%y %T "

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color'
alias wo='workon'
alias dc='docker-compose'
alias ag='ag --ignore tags --ignore *.sql'
alias s='git status'
alias go='git add .; git commit -am go; git push origin master'
alias vim='bash /home/danilo/scripts/run_vim'

. $HOME/.git-prompt.sh

# VIRTUALENVWRAPPER
export WORKON_HOME=$HOME/.virtualenvs
source /usr/bin/virtualenvwrapper.sh

# BASH COMPLETION
[[ $PS1 && -f /usr/share/bash-completion/bash_completion.sh ]] && \
    source /usr/local/share/bash-completion/bash_completion.sh

if [ $TERM == 'linux' ]; then
    PS1='[\u@\h \W]\$ '
else
    #PS1='$(__git_ps1 "[$VENV/\[\e[34m\]%s\[\e[m]\]")[\[\e[32m\]\u\[\e[m\] \[\e[33m\]\W\[\e[m\]]\$ '
    PS1='$VENV$(__git_ps1 "[\[\e[34m\]%s\[\e[m]\]")[\[\e[32m\]\u\[\e[m\] \[\e[33m\]\W\[\e[m\]]\$ '
fi




# COLORED MANUALS
export LESS_TERMCAP_mb=$'\e[1;32m'
export LESS_TERMCAP_md=$'\e[1;32m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[01;33m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[1;4;31m'


# Dolphin
export XDG_CURRENT_DESKTOP=kde

# Added by n-install (see http://git.io/n-install-repo).
export N_PREFIX="$HOME/n"; [[ :$PATH: == *":$N_PREFIX/bin:"* ]] || PATH+=":$N_PREFIX/bin"  


export ANDROID_HOME=/home/danilo/android

export PATH=$PATH:/home/danilo/.local/bin:/home/danilo/www/stroller/bin
