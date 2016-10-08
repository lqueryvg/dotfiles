# common to bash and zsh

#echo .my_profile.sh start
source_if_exists  ~/.my_aliases
source_if_exists ${HOME}/.winerc

prepend_path_if_exists   \
  ${HOME}/bin            \
  ${HOME}/dotfiles/bin   \
  /home/local/bin        \
  ${HOME}/homebrew/bin   \
  ${HOME}/.linuxbrew/bin \
  ${HOME}/.linuxbrew/sbin \
  $HOME/.rbenv/bin

# Haskell stuff
append_path_if_exists ${HOME}/.cabal/bin

# suppress accessibility bus error start gnome apps from shell prompt
export NO_AT_BRIDGE=1

#export PATH="$HOME/.rbenv/bin:$PATH"

#command_exists rbenv && {
#  eval "$(rbenv init -)"
#  rbenv shell 2.0.0-p598
#}

#test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"
#. /Users/jbu46/homebrew/lib/python2.7/site-packages/powerline/bindings/bash/powerline.sh
#



#echo .my_profile end
