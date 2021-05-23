echo .bashrc start

. ~/dotfiles/my_functions.sh
source_if_exists ~/.my_profile.sh

echo .bashrc end


[ -f ~/.fzf.bash ] && source ~/.fzf.bash
