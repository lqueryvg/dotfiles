# source the users bashrc if it exists
if [ -f "${HOME}/.bashrc" ] ; then
  source "${HOME}/.bashrc"
fi

if [ -f "${HOME}/.winerc" ] ; then
  source "${HOME}/.winerc"
fi

# Set PATH so it includes user's private bin if it exists
if [ -d "${HOME}/bin" ] ; then
  PATH="${HOME}/bin:${PATH}"
fi

# Add my local software if any
if [ -d "/home/local/bin" ] ; then
  PATH="/home/local/bin:${PATH}"
fi
