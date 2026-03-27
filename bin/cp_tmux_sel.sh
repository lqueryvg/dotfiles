#!/bin/bash
#
# Copy tmux selection to system clipboard.
#

if [[ `uname` =~ CYGWIN ]]
then
    tmux show-buffer | perl -pi -e 's/\n/\r\n/g' > /dev/clipboard
    tmux display-message "tmux selection copied to Windows clipboard"
else
    hash xsel 2>/dev/null || { echo "ERROR: xsel not found"; exit 1; }

    tmux show-buffer | xsel -i
    tmux display-message "tmux selection copied to X clipboard"
fi
