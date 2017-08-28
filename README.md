# mycaketest

This code provides a templates for running a simple one node deployment on AWS vpc environment.
For multi-node architecture use the [multinode](https://github.com/ravibhure/mycaketest/tree/multinode) branch

This will start ec2 instance and setup the following docker stack.

1) wordpress
2) promethus
3) grafana

# pre-requiste on local

* [ansible](http://docs.ansible.com/ansible/latest/intro_installation.html)
* [python-boto](https://pypi.python.org/pypi/boto)
* [docker-engine](https://docs.docker.com/engine/installation/)
* [docker-compose](https://docs.docker.com/compose/install/)
* [terraform](https://releases.hashicorp.com/terraform/0.8.8/) - for terraform based deployment


## pre-requiste to run deployment

Before start the deployment..

Update `ansible.cfg` with your `private_key_file` location, this key will be used to connect to ec2 instance.

Copy `install/env.sh.example` to `install/env.sh` and update aws access secret and other details in `install/env.sh`


### Deployment using Ansible


```
cd install
bash ensure-infra-with-ansible.sh
```

### Deployment using Terraform


``` 
cd install
bash ensure-infra-with-terraform.sh
```

### Accessing Wordpress

Navigate to `http://<host-ip>:80`

### Accessing and Setting up Grafana

Navigate to `http://<host-ip>:8090` and login with user ***admin*** password ***changeme***. You can change the password from Grafana UI.

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
