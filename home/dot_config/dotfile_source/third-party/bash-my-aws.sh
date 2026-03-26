if [[ -d "${HOME}/.bash-my-aws" ]]; then
  PATH="${HOME}/.bash-my-aws/bin:${PATH}"
  source "${HOME}/.bash-my-aws/aliases"
  autoload -U +X compinit && compinit
  autoload -U +X bashcompinit && bashcompinit
  source "${HOME}/.bash-my-aws/bash_completion.sh"
fi
