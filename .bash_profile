# source the users bashrc if it exists
if [ -f "${HOME}/.bashrc" ] ; then
  source "${HOME}/.bashrc"
fi

if [ -f "${HOME}/.winerc" ] ; then
  source "${HOME}/.winerc"
fi

# Set PATH so it includes user's private bin if it exists
if [ -d "${HOME}/bin" ] ; then
  PATH="${HOME}/bin:${HOME}/dotfiles/bin:${PATH}"
fi

# Add my local software if any
if [ -d "/home/local/bin" ] ; then
  PATH="/home/local/bin:${PATH}"
fi

# suppress accessibility bus error start gnome apps from shell prompt
export NO_AT_BRIDGE=1
