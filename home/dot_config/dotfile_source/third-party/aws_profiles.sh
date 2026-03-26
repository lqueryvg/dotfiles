lsp_raw() {
  grep '\[profile' ~/.aws/config | grep -v '^#' | sed -e 's@.* @@' -e 's@]@@'
}

lsp() {
  for profile in $(lsp_raw); do
    if [[ $profile == $AWS_PROFILE ]]; then
      echo "* $profile"
    else
      echo "  $profile"
    fi
  done
}

awe() {
  export AWS_PROFILE="$1"
  echo "AWS_PROFILE=$AWS_PROFILE"
}

awp() {
  if [[ -z "$1" && -n "$AWS_PROFILE" ]]; then
    awe "$AWS_PROFILE"
  else
    awe "$1"
  fi
  aws-azure-login --no-prompt
}

_awp() { _arguments ':Aws profile:($(lsp_raw))' }
_awe() { _arguments ':Aws profile:($(lsp_raw))' }
compdef _awp awp
compdef _awe awe
compdump
