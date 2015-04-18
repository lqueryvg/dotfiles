# If not running interactively, don't do anything
[[ "$-" != *i* ]] && return

# Make bash append rather than overwrite the history on disk
#shopt -s histappend

# Uncomment to turn on programmable completion enhancements.
# Any completions you add in ~/.bash_completion are sourced last.
[[ -f /etc/bash_completion ]] && . /etc/bash_completion

[[ -f ~/.bash_aliases ]] && . ~/.bash_aliases

d=~/.dircolors
test -r $d && eval "$(dircolors $d)"

settitle () 
{ 
   echo -ne "\e]2;$@\a\e]1;$@\a"; 
}

xt() {
    [[ ! -d $1 ]] && (echo "need a dir"; return)
    cd $1
    nohup xterm 2>&1 2>/dev/null &
}

xv() {
    nohup xterm -e vim $* 2>&1 2>/dev/null &
}

set -o vi
export PS1="$(hostname -s)$ "
export TERM=xterm-256color
export TERMCMD=xterm
#export TERM=xterm
export CDPATH=.:~/Documents:~/Downloads:~

# do not echo "^C" when pressing ^c
# otherwise it blats part of command making copy/paste harder
stty -echoctl

# TODO make a make a ~/.bash_completion.d directory
# bash completion for tmux commands
#source_if_exists ~/dotfiles/bin/bash_completion_tmux.sh
#source /etc/bash_completion.d/git
bcdir=~/dotfiles/bash_completion.d
[[ -d $bcdir ]] && for file in $bcdir/*
do
    source $file
done
