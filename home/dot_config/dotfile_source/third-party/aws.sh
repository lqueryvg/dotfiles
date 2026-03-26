export AWS_SDK_LOAD_CONFIG=1
alias cfn='aws cloudformation'

ssmget()     { set -x; aws ssm get-parameters --names "$1" --with-decryption --query 'Parameters[0].Value' --output text }
ssmls()      { set -x; aws ssm describe-parameters --query 'Parameters[*].[Name,Type]' --output table }
ssmput()     { set -x; aws ssm put-parameter --name "$1" --value "$2" --type String --overwrite }
ssmputs()    { set -x; aws ssm put-parameter --name "$1" --value "$2" --type SecureString --overwrite }
ssmputsFile(){ set -x; aws ssm put-parameter --name "$1" --value "$(cat "$2")" --type SecureString --overwrite }
ssmdel()     { set -x; aws ssm delete-parameter --name "$1" }
ssmdump()    { set -x; aws ssm get-parameters-by-path --path / --with-decryption --recursive }
ssmdescribe(){ set -x; aws ssm describe-parameters --query 'Parameters[*].[Name,Description]' --output table }
