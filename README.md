In Progress...
# mycaketest

# pre-requiste on local

ansible
python-boto
docker-compose
docker-engine
terraform (for terraform based deployment)

# Running deployment

### Ansible

Update `ansible.cfg` with your `private_key_file` location

Provide your aws access secret in environment variable

```
ansible-playbook site.yml -e "my_aws_access_key=xxxxxxxxxxxxxxxxxxxx my_aws_secret_key=xxxxxxxxxxxxxxxxxxx"

```

### Terraform

Update you aws access secret in `terraform.tfvars.example` file

``` 
terraform apply 
```
