$(command_exists aws) || return
$(command_exists kops) || return

export AWS_ACCESS_KEY_ID=$(aws --profile kops configure get aws_access_key_id)
export AWS_SECRET_ACCESS_KEY=$(aws --profile kops configure get aws_secret_access_key)
