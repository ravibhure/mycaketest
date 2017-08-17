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

Update/Edit `vars.yml` with your aws environment details

Provide your aws access secret in `vars.yml` or command extra variable

```
ansible-playbook site.yml -e "my_aws_access_key=xxxxxxxxxxxxxxxxxxxx my_aws_secret_key=xxxxxxxxxxxxxxxxxxx"

```

### Terraform

Update you aws access secret in `terraform.tfvars.example` file

``` 
terraform apply 
```

### Accessing Wordpress

Navigate to http://<host-ip>:80

### Setup Grafana

Navigate to http://<host-ip>:8080 and login with user admin password changeme. You can change the password from Grafana UI.

From the Grafana menu, choose Data Sources and click on Add Data Source. Use the following values to add the Prometheus container as data source:

Name: Prometheus
Type: Prometheus
Url: http://localhost:9090
Access: proxy

Now you can import the dashboard temples from the [grafana](https://github.com/ravibhure/mycaketest/tree/master/grafana) directory. From the Grafana menu, choose Dashboards and click on Import.


