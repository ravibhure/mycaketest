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
    from_port = 8080
    to_port = 8080
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Prometheus access from anywhere
  ingress {
    from_port = 9100
    to_port = 9100
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
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

resource "null_resource" "wordpress" {
  depends_on = ["aws_instance.webserver"]

  provisioner "local-exec" {
    command = "echo \"${aws_instance.webserver.public_ip} ansible_user=ubuntu\" > ${path.module}/terraform_hosts"
  }
  provisioner "local-exec" {
    command = "ANSIBLE_CONFIG=${path.module}/.. ansible-playbook -i ${path.module}/terraform_hosts ${path.module}/../wordpress.yml"
  }
}
