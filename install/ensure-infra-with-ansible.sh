#!/usr/bin/env bash

set -e

source env.sh

# Run ansible
cd ${PWD}/..

ansible-playbook ANSIBLE_CONFIG=${PWD} site.yml \
-e "aws_env=${AWS_ENV}" \
-e "aws_access_key=${CAKE_AWS_ACCESS_KEY_ID}" \
-e "aws_secret_key=${CAKE_AWS_SECRET_ACCESS_KEY}" \
-e "aws_region=${CAKE_AWS_REGION}" \
-e "aws_vpc_id=${CAKE_AWS_VPC_ID}" \
-e "aws_vpc_subnet_id=${CAKE_SUBNET_ID}" \
-e "aws_key_name=${CAKE_KEY_NAME}" \
-e "aws_key_path=${CAKE_KEY_PATH}" \
-e "aws_instance_type=${CAKE_INSTANCE_TYPE}" \
-e "aws_ec2_ami=${CAKE_EC2_AMI}"
