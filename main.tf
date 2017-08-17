# VARIABLES
variable "access_key" {}
variable "secret_key" {}

variable "aws_region" {
  description = "AWS region to launch servers."
  default = "us-west-2"
}

variable "key_name" {
  description = "Name of the SSH keypair to use in AWS."
  default = "ravi"
}

variable "key_path" {
  description = "Path to the private portion of the SSH key specified."
  default = "~/.ssh/ravi.pem"
}

variable "vpc_id" {
  default = "vpc-cc79c8aa"
}

variable "subnet_id" {
  default = "subnet-af960af4"
}

variable "ec2_ami" {
  default = "ami-d94f5aa0"
}

variable "instance_type" {
  default = "t2.micro"
}

# PROVIDER
provider "aws" {
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
  region     = "${var.aws_region}"
}

# SECURITY GROUP
# Our default security group to access
resource "aws_security_group" "webserver" {
  name = "webserver"
  description = "Used in LAMP"

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
  ingress {
    from_port = 8080
    to_port = 8080
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

  vpc_id = "${var.vpc_id}"
  tags {
    Name        = "webserver"
  }

}

# LAMP SERVER
resource "aws_instance" "webserver" {
  ami = "${var.ec2_ami}"
  instance_type = "${var.instance_type}"
  vpc_security_group_ids = ["${aws_security_group.webserver.id}"]
  associate_public_ip_address = true
  subnet_id = "${var.subnet_id}"
  count = 1
  connection {
    user = "ubuntu"
    key_file = "${var.key_path}"
  }
  key_name = "${var.key_name}"
  tags {
    Name = "webserverhost"
  }
}

resource "null_resource" "wordpress" {
  depends_on = ["aws_instance.webserver"]

  provisioner "local-exec" {
    command = "echo \"${aws_instance.webserver.public_ip} ansible_user=ubuntu\" > terraform_hosts"
  }
  provisioner "local-exec" {
    command = "ansible-playbook -i terraform_hosts wordpress.yml"
  }

}

# OUTPUT
output "lamp_url" {
  value = "http://${aws_instance.webserver.public_ip}:80"
}
