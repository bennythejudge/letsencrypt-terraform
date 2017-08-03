# source me
# expects ~/.aws/credentials to contain the values in format name=value no spaces etc..
export AWS_ACCESS_KEY_ID=$(grep  aws_access_key_id ~/.aws/credentials | awk -F '=' '{print $2}')
export AWS_SECRET_ACCESS_KEY=$(grep  aws_secret_access_key  ~/.aws/credentials | awk -F '=' '{print $2}')
export AWS_DEFAULT_REGION=eu-west-2

export TF_VAR_demo_acme_challenge_aws_access_key_id=$AWS_ACCESS_KEY_ID 
export TF_VAR_demo_acme_challenge_aws_secret_access_key=$AWS_SECRET_ACCESS_KEY
export TF_VAR_demo_acme_challenge_aws_region=$AWS_DEFAULT_REGION
