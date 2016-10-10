#echo .bashrc start

. ~/dotfiles/my_functions.sh
source_if_exists ~/.my_profile.sh

# If not running interactively, don't do any more
[[ "$-" != *i* ]] && return

source_if_exists                    \
  /etc/.bash_completion             \
  /etc/profile.d/bash_completion.sh \
  ~/.bash_completion

powerline=~/mygit/powerline-shell/powerline-shell.py
if [[ -x $powerline ]]
then
  function _update_ps1() {
    PS1="$($powerline         \
            --cwd-max-depth 2 \
            --mode compatible \
            $? 2> /dev/null)"
  }

  if [ "$TERM" != "linux" ]; then
    PROMPT_COMMAND="_update_ps1; $PROMPT_COMMAND"
  fi
else
  PS1=$(whoami)"$ "
fi

d=~/homebrew/etc/bash_completion.d
[[ -d $d ]] && {
    for file in $d/*
    do
      . $file
    done
}

settitle () { echo -ne "\e]2;$@\a\e]1;$@\a"; }

set -o vi
export TERMCMD=xterm
export CDPATH=.:~/Documents:~/Downloads:~
export VAGRANT_DEFAULT_PROVIDER=libvirt

# do not echo "^C" when pressing ^c
# otherwise it blats part of command making copy/paste harder
stty -echoctl

# TODO make a make a ~/.bash_completion.d directory
# bash completion for tmux commands
#source_if_exists ~/dotfiles/bin/bash_completion_tmux.sh
bcdir=~/dotfiles/bash_completion.d
[[ -d $bcdir ]] && for file in $bcdir/*
do
    source $file
done
stty -ixoff
stty stop undef
stty start undef

#shopt -s histappend      # append rather than overwrite history on disk
#echo .bashrc end
