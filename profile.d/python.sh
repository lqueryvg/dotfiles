if [[ -d $HOME/.pyenv ]]
then
    export PYENV_ROOT="$HOME/.pyenv"
    prepend_path_if_exists $PYENV_ROOT/bin
    if command -v pyenv 1>/dev/null 2>&1
    then
      eval "$(pyenv init -)"
      eval "$(pyenv virtualenv-init -)"
    fi
    export PYENV_VIRTUALENV_DISABLE_PROMPT=1
fi
