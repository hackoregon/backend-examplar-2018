#! /bin/bash

# Pulls in HackO API env var values as parameters from AWS Parameter Store
# Depends on pre-installed awscli

# Modelled on https://aws.amazon.com/blogs/compute/managing-secrets-for-amazon-ecs-applications-using-parameter-store-and-iam-roles-for-tasks/

# TODO:
# 1. determine the values of the prefixes for each of the Parameter Store parameters (e.g. /production/2018/) that pass into the --names flag
# 2. echo out the parameter values so they can be used by the container apps
# 3. determine the best place to run this script so that it populates the env vars before they're needed by other code

EC2_REGION = "us-west-2" # unfortunately cannot rely on dynamic env var values that this script is meant to pull in
PROJECT_NAME = "disaster-resilience" # must be set to each project's "Final naming convention" from here https://github.com/hackoregon/civic-devops/issues/1

# Get unencrypted values
POSTGRES_HOST=`aws ssm get-parameters --names "/production/2018/API/$PROJECT_NAME/POSTGRES_HOST" --no-with-decryption --region $EC2_REGION --output text 2>&1`
POSTGRES_NAME=`aws ssm get-parameters --names "/production/2018/API/$PROJECT_NAME/POSTGRES_NAME" --no-with-decryption --region $EC2_REGION --output text 2>&1`
POSTGRES_PORT=`aws ssm get-parameters --names "/production/2018/API/$PROJECT_NAME/POSTGRES_PORT" --no-with-decryption --region $EC2_REGION --output text 2>&1`
POSTGRES_USER=`aws ssm get-parameters --names "/production/2018/API/$PROJECT_NAME/POSTGRES_USER" --no-with-decryption --region $EC2_REGION --output text 2>&1`

# Get encrypted values
DJANGO_SECRET_KEY=`aws ssm get-parameters --names "/production/2018/API/$PROJECT_NAME/DJANGO_SECRET_KEY" --with-decryption --region $EC2_REGION --output text 2>&1`
POSTGRES_PASSWORD=`aws ssm get-parameters --names "/production/2018/API/$PROJECT_NAME/POSTGRES_PASSWORD" --with-decryption --region $EC2_REGION --output text 2>&1`

# Set environment variables in the container
export DJANGO_SECRET_KEY=$DJANGO_SECRET_KEY
export POSTGRES_HOST=$POSTGRES_HOST
export POSTGRES_NAME=$POSTGRES_NAME
export POSTGRES_PASSWORD=$POSTGRES_PASSWORD
export POSTGRES_PORT=$POSTGRES_PORT
export POSTGRES_USER=$POSTGRES_USER
