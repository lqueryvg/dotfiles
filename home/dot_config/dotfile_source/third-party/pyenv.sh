if [[ -d "${HOME}/.pyenv" ]]; then
  export PYENV_ROOT="${HOME}/.pyenv"
  [[ -d "${PYENV_ROOT}/bin" ]] && PATH="${PYENV_ROOT}/bin:${PATH}"
  export PATH
  if command -v pyenv &>/dev/null; then
    eval "$(pyenv init --path)"
    eval "$(pyenv virtualenv-init -)"
  fi
  export PYENV_VIRTUALENV_DISABLE_PROMPT=1
fi
