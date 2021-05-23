$(command_exists aws) || return

export PATH="$PATH:$HOME/.bash-my-aws/bin"
source ~/.bash-my-aws/aliases

if [[ $SHELL_IS_ZSH == "true" ]]
then
  autoload -U +X compinit && compinit
  autoload -U +X bashcompinit && bashcompinit
fi

source ~/.bash-my-aws/bash_completion.sh

