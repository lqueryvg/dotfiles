if [[ -d "${HOME}/gopath" ]]; then
  export GOPATH="${HOME}/gopath"
  [[ -d "${GOPATH}/bin" ]] && PATH="${GOPATH}/bin:${PATH}"
fi

if [[ -d /usr/local/go ]]; then
  PATH="/usr/local/go/bin:${PATH}"
fi

export PATH
