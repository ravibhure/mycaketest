#!/usr/bin/env bash

set -e

source env.sh

# Run terraform
cd ${PWD}/..

terraform apply \
-var="aws_env=${AWS_ENV}" \
-var="aws_access_key=${CAKE_AWS_ACCESS_KEY_ID}" \
-var="aws_secret_key=${CAKE_AWS_SECRET_ACCESS_KEY}" \
-var="aws_region=${CAKE_AWS_REGION}" \
-var="aws_vpc_id=${CAKE_AWS_VPC_ID}" \
-var="aws_vpc_subnet_id=${CAKE_SUBNET_ID}" \
-var="aws_key_name=${CAKE_KEY_NAME}" \
-var="aws_key_path=${CAKE_KEY_PATH}" \
-var="aws_instance_type=${CAKE_INSTANCE_TYPE}" \
-var="aws_ec2_ami=${CAKE_EC2_AMI}" \
-state="${PWD}/terraform/terraform.tfstate" \
"${PWD}/terraform"
