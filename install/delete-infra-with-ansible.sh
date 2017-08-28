#!/usr/bin/env bash

set -e

source env.sh

# Run ansible
cd ${PWD}/..

echo -n "Enter wordpress InstanceID and press [ENTER]: "
read wp_instanceid

echo -n "Enter monitoring InstanceID and press [ENTER]: "
read mon_instanceid

ansible-playbook terminate.yml \
-e "aws_env=${AWS_ENV}" \
-e "aws_access_key=${CAKE_AWS_ACCESS_KEY_ID}" \
-e "aws_secret_key=${CAKE_AWS_SECRET_ACCESS_KEY}" \
-e "aws_region=${CAKE_AWS_REGION}" \
-e "aws_key_name=${CAKE_KEY_NAME}" \
-e "aws_key_path=${CAKE_KEY_PATH}" \
-e "wp_instance_ids=${wp_instanceid}" \
-e "mon_instance_ids=${mon_instanceid}"
