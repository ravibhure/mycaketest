# VARIABLES
variable "aws_access_key" {}
variable "aws_secret_key" {}

variable "aws_region" {
  description = "AWS region to launch servers."
  default = "us-west-2"
}

variable "aws_env" {
  description = "AWS environment."
  default = "test"
}

variable "blog_domain" {
  description = "Blog domain."
  default = "blog.cakesolution.co.uk"
}

variable "gf_admin_password" {
  description = "Grafana admin password."
  default = "changeme"
}

variable "aws_key_name" {
  description = "Name of the SSH keypair to use in AWS."
  default = "ravi"
}

variable "aws_key_path" {
  description = "Path to the private portion of the SSH key specified."
  default = "~/.ssh/ravi.pem"
}

variable "aws_vpc_id" {
  description = "AWS VPC ID."
  default = "vpc-cc79c8aa"
}

variable "aws_vpc_subnet_id" {
  description = "Subnet ID for AWS VPC."
  default = "subnet-af960af4"
}

variable "aws_ec2_ami" {
  description = "AWS AMI ubuntu 14.04."
  default = "ami-d94f5aa0"
}

variable "aws_instance_type" {
  description = "AWS Instance type."
  default = "t2.micro"
}
