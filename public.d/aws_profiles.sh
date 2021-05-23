# AWS profiles

function lsp_raw() {
  grep '\[profile' ~/.aws/config | grep -v '^#' | sed -e 's@.* @@' -e 's@]@@'
}

function lsp() {
  for profile in $(lsp_raw)
  do
    if [[ $profile == $AWS_PROFILE ]]
    then
      echo "* $profile"
    else
      echo "  $profile"
    fi
  done
}

function awe() {
  export AWS_PROFILE=$1
  echo "AWS_PROFILE=$AWS_PROFILE"
}

function awp() {
  if [[ $1 == "" && $AWS_PROFILE != "" ]]
  then
    awe $AWS_PROFILE
  else
    awe $1
  fi
  aws-azure-login --no-prompt
}

is_zsh || return
is_interactive || return

function _awp() {
  _arguments ':Aws profile:($(lsp_raw))'
}

function _awe() {
  _arguments ':Aws profile:($(lsp_raw))'
}

compdef _awp awp
compdef _awe awe
compdump
