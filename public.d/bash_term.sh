# Only run for interactive BASH
[[ $SHELL_IS_INTERACTIVE != true ]] && return
[[ $SHELL_IS_BASH != true ]] && return

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


