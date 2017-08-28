# PROVIDER
provider "aws" {
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
  region     = "${var.aws_region}"
}

# SECURITY GROUP
# Our default security group to access
resource "aws_security_group" "webserver" {
  name = "webserver"
  description = "Used in webserver"

  # SSH access from anywhere
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # HTTP access from anywhere
  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  # Prometheus UI access from anywhere
  ingress {
    from_port = 8090
    to_port = 8090
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # internal all
  ingress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    self = true
  }

  # outbound internet access
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  vpc_id = "${var.aws_vpc_id}"
  tags {
    Name = "webserver"
    Environment = "${var.aws_env}"
  }

}

# MONITORING SERVER
resource "aws_instance" "monitoring" {
  ami = "${var.aws_ec2_ami}"
  instance_type = "${var.aws_instance_type}"
  vpc_security_group_ids = ["${aws_security_group.webserver.id}"]
  associate_public_ip_address = true
  subnet_id = "${var.aws_vpc_subnet_id}"
  count = 1
  connection {
    user = "ubuntu"
    key_file = "${var.aws_key_path}"
  }
  key_name = "${var.aws_key_name}"
  tags {
    Name = "monitoring"
    Monitoring = "On"
    Environment = "${var.aws_env}"
  }
}

# LAMP SERVER
resource "aws_instance" "webserver" {
  ami = "${var.aws_ec2_ami}"
  instance_type = "${var.aws_instance_type}"
  vpc_security_group_ids = ["${aws_security_group.webserver.id}"]
  associate_public_ip_address = true
  subnet_id = "${var.aws_vpc_subnet_id}"
  count = 1
  connection {
    user = "ubuntu"
    key_file = "${var.aws_key_path}"
  }
  key_name = "${var.aws_key_name}"
  tags {
    Name = "webserver"
    Monitoring = "On"
    Environment = "${var.aws_env}"
  }
}

resource "null_resource" "inventory" {
  depends_on = ["aws_instance.monitoring","aws_instance.webserver"]

  provisioner "local-exec" {
    command = "echo \"[monitoring]\n${aws_instance.monitoring.public_ip} ansible_user=ubuntu\" > ${path.module}/terraform_hosts"
  }
  provisioner "local-exec" {
    command = "echo \"[webserver]\n${aws_instance.webserver.public_ip} ansible_user=ubuntu\" >> ${path.module}/terraform_hosts"
  }
}

resource "null_resource" "setup_wordpress" {
  depends_on = ["null_resource.inventory"]

  provisioner "local-exec" {
    command = "ANSIBLE_CONFIG=${path.module}/.. ansible-playbook -i ${path.module}/terraform_hosts ${path.module}/../wordpress.yml -e 'aws_access_key=${var.aws_access_key} aws_secret_key=${var.aws_secret_key} gf_admin_password=${var.gf_admin_password} blog_domain=${var.blog_domain}'"
  }
}
