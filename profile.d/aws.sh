# https://github.com/serverless/serverless/issues/3833#issuecomment-398642431
# sls deploy "Profile blah does not exist" problem
export AWS_SDK_LOAD_CONFIG=1

function ssmget() {
  set -x
  aws ssm get-parameters --names $1   \
    --with-decryption                 \
    --query 'Parameters[0].Value'     \
    --output text
}

function ssmls() {
  set -x
  aws ssm describe-parameters --query 'Parameters[*].[Name,Type]' --output table
}

function ssmput() {
  set -x
  aws ssm put-parameter --name $1 --value $2 --type String --overwrite
}

function ssmputs() {  # s for secure!
  set -x
  aws ssm put-parameter --name $1 --value $2 --type SecureString --overwrite
}

function ssmdel() {
  set -x
  aws ssm delete-parameter --name $1
}

function ssmcp() {
  [[ $# == 2 ]] || {
    echo "Usage:"
    echo "  source-param target-param"
    echo "  source-param aws-profile:"
    echo "  source-param aws-profile:target-param"
    return 1
  }
  source_param=$1
  if [[ $2 == *: ]]; then
    target_profile=${2%:}
    target_param=$source_param
  elif [[ $2 == *:* ]]; then
    target_profile=${2//:*/}
    target_param=${2//*:/}
  else
    target_profile=$AWS_PROFILE
    target_param=$2
  fi

  echo $source_param $target_profile $target_param

  aws ssm get-parameters --names $source_param \
    --with-decryption                          \
    --query 'Parameters[0].[Value,Type]'       \
    --output text | read value type
  [[ $value == None ]] && {
    echo "unable to get value of $source_param"
    return 1
  }
  set -x
  echo AWS_PROFILE=$target_profile aws ssm put-parameter --name $target_param \
    --value $value --type $type --overwrite
}
