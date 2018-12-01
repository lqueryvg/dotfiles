echo .bash_profile start

source ~/dotfiles/my_functions.sh
exec_if_exists $HOME/homebrew/bin/zsh
source_if_exists $HOME/.bashrc

export PATH=$PATH:$HOME/bin

echo .bash_profile end
