terraform {
  backend "s3" {
    encrypt = true
  }
}

provider "aws" {}

data "aws_vpc" "vpc_data" {
  id = var.vpc_id
}

data "aws_subnet_ids" "subnets_ids" {
  vpc_id = data.aws_vpc.vpc_data.id
}

data "aws_ssm_parameter" "ami" {
  name = "/aws/service/ami-amazon-linux-latest/amzn2-ami-hvm-x86_64-gp2"
}

data "template_file" "userdata" {
  template = file("${path.module}/userdata.sh")
}