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

function ssmputsFile() {  # s for secure!
  set -x
  aws ssm put-parameter --name $1 --value "$(cat $2)" --type SecureString --overwrite
}

function ssmdel() {
  set -x
  aws ssm delete-parameter --name $1
}

function ssmdump() {
  set -x
  aws ssm get-parameters-by-path --path / --with-decryption --recursive
}

function ssmdescribe() {
  set -x
  aws ssm describe-parameters   --query 'Parameters[*].[Name,Description]' --output table
}

