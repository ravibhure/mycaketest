In Progress...
# mycaketest

# pre-requiste on local

[ansible](http://docs.ansible.com/ansible/latest/intro_installation.html)
[python-boto](https://pypi.python.org/pypi/boto)
[docker-engine](https://docs.docker.com/engine/installation/)
[docker-compose](https://docs.docker.com/compose/install/)
[terraform](https://releases.hashicorp.com/terraform/0.8.8/) - for terraform based deployment

# Running deployment

Before start the deployment..

Update `ansible.cfg` with your `private_key_file` location, this key will be used to connect to ec2 instance.

Copy `install/env.sh.example` to `install/env.sh` and update aws access secret and other details in `install/env.sh`


### Using Ansible


```
cd install
bash ensure-infra-with-ansible.sh
```

### Using Terraform


``` 
cd install
bash ensure-infra-with-terraform.sh
```

### Accessing Wordpress

Navigate to `http://<host-ip>:80`

### Setup Grafana

Navigate to `http://<host-ip>:8080` and login with user ***admin*** password ***changeme***. You can change the password from Grafana UI.

From the Grafana menu, choose Data Sources and click on Add Data Source. Use the following values to add the Prometheus container as data source:

* Name: Prometheus
* Type: Prometheus
* Url: http://prometheus:9090
* Access: proxy

Now you can import the dashboard temples from the [grafana](https://github.com/ravibhure/mycaketest/tree/master/grafana) directory. From the Grafana menu, choose Dashboards and click on Import.

### Destroy deployment

* Ansible

``` 
cd install
bash delete-infra-with-ansible.sh
```

* Terraform

``` 
cd install
bash delete-infra-with-terraform.sh
```
