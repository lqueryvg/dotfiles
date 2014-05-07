#!/usr/bin/bash
#
# Copy tmux selection to system clipboard.
#

if [[ `uname` =~ CYGWIN ]]
then
    tmux show-buffer | perl -pi -e 's/\n/\r\n/g' > /dev/clipboard
    tmux display-message "tmux selection copied to system clipboard"
else
    echo "ERROR: $0 does not yet ported to this os"
fi
