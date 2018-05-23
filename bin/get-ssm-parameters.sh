#! /bin/bash

# Pulls in HackO API env var values as parameters from AWS Parameter Store
# Depends on pre-installed awscli

# Modelled on https://aws.amazon.com/blogs/compute/managing-secrets-for-amazon-ecs-applications-using-parameter-store-and-iam-roles-for-tasks/

EC2-REGION = "us-west-2" # unfortunately cannot rely on the env var values that this script is meant to pull in

#APP1_WITH_ENCRYPTION=`aws ssm get-parameters --names prod.app1.db-pass --with-decryption --region $EC2_REGION --output text 2>&1`
#APP1_WITHOUT_ENCRYPTION=`aws ssm get-parameters --names prod.app1.db-pass --no-with-decryption --region $EC2_REGION --output text 2>&1`
#LICENSE_WITH_ENCRYPTION=`aws ssm get-parameters --names general.license-code --with-decryption --region $EC2_REGION --output text 2>&1`
#LICENSE_WITHOUT_ENCRYPTION=`aws ssm get-parameters --names general.license-code --no-with-decryption --region $EC2_REGION --output text 2>&1`
#APP2_WITHOUT_ENCRYPTION=`aws ssm get-parameters --names prod.app2.user-name --no-with-decryption --region $EC2_REGION --output text 2>&1`

# TODO:
# 1. determine the values of the prefixes for each of the Parameter Store parameters (e.g. /production/2018/) that pass into the --names flag
# 2. echo out the parameter values so they can be used by the container apps
# 3. determine the best place to run this script so that it populates the env vars before they're needed by other code
