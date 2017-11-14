#echo .bash_profile start

source ~/dotfiles/my_functions.sh
exec_if_exists $HOME/homebrew/bin/zsh
source_if_exists $HOME/.bashrc
#echo .bash_profile end

export PATH=$PATH:$HOME/bin

source_if_exists ~/lib/azure-cli/az.completion'
