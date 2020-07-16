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

function awp() {
  export AWS_PROFILE=$1
  echo "AWS_PROFILE=$AWS_PROFILE"
  aws-azure-login --no-prompt
}

[[ $SHELL_IS_ZSH != "true" ]] && return
[[ $SHELL_IS_INTERACTIVE != "true" ]] && return

function _awp() {
  _arguments ':Aws profile:($(lsp_raw))'
}

compdef _awp awp
compdump
