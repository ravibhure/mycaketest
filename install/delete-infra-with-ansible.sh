#!/usr/bin/env bash

set -e

source env.sh

# Run ansible
cd ${PWD}/..

echo -n "Enter InstanceID and press [ENTER]: "
read instanceid

ansible-playbook ANSIBLE_CONFIG=${PWD} terminate.yml \
-e "aws_env=${AWS_ENV}" \
-e "aws_access_key=${CAKE_AWS_ACCESS_KEY_ID}" \
-e "aws_secret_key=${CAKE_AWS_SECRET_ACCESS_KEY}" \
-e "aws_region=${CAKE_AWS_REGION}" \
-e "aws_key_name=${CAKE_KEY_NAME}" \
-e "aws_key_path=${CAKE_KEY_PATH}" \
-e "instance_ids=${instanceid}"
