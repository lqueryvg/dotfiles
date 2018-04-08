# common to bash and zsh

#echo .my_profile.sh start
#

case $- in
  *i*)
      # This shell is interactive
      # editor to use when pressing 'v' in command line edit
      export VISUAL=vim
      source_if_exists  ~/.my_aliases
      title $(uname -n)
      ;;
  *) 
      # This is a script
      ;;
esac

source_if_exists ${HOME}/.winerc

prepend_path_if_exists            \
  ${HOME}/bin                     \
  ${HOME}/dotfiles/bin            \
  /home/local/bin                 \
  /home/linuxbrew/.linuxbrew/bin  \
  /home/linuxbrew/.linuxbrew/sbin \
  $HOME/.rbenv/bin                \
  $HOME/gopath/bin

# Haskell stuff
append_path_if_exists ${HOME}/.cabal/bin


# suppress accessibility bus error start gnome apps from shell prompt
export NO_AT_BRIDGE=1

#test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"
#. /Users/jbu46/homebrew/lib/python2.7/site-packages/powerline/bindings/bash/powerline.sh
#

export GOPATH=$HOME/gopath

if [ -z "$SSH_AUTH_SOCK" ] ; then
  eval `ssh-agent -s`
  ssh-add
fi

source_if_exists ${HOME}/.local_profile

#echo .my_profile end
