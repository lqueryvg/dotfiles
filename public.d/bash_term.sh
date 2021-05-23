is_bash || return
is_interactive || return

settitle () { echo -ne "\e]2;$@\a\e]1;$@\a"; }

set -o vi
export TERMCMD=xterm
export CDPATH=.:~/Documents:~/Downloads:~

# do not echo "^C" when pressing ^c
# otherwise it blats part of command making copy/paste harder
stty -echoctl
stty -ixoff
stty stop undef
stty start undef

export BASH_SILENCE_DEPRECATION_WARNING=1
