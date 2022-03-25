$(command_exists aws) || return

append_path_if_exists $HOME/.bash-my-aws/bin

if [[ -d ~/.bash-my-aws ]]
then
  source ~/.bash-my-aws/aliases
fi

if [[ $SHELL_IS_ZSH == "true" ]]
then
  autoload -U +X compinit && compinit
  autoload -U +X bashcompinit && bashcompinit
fi


if [[ -d ~/.bash-my-aws ]]
then
  source ~/.bash-my-aws/bash_completion.sh
fi
