provider "aws" {}

data "aws_caller_identity" "caller_identity" {}

data "aws_vpc" "vpc_data" {
  id = var.vpc_id
}

data "aws_subnet_ids" "subnets_ids" {
  vpc_id = data.aws_vpc.vpc_data.id
  filter {
    name = "tag:Name"
    values = [var.private_subnet_1, var.private_subnet_2]
  }
}

variable "aws_region" {}

variable "database_user" {}

variable "vpc_id" {}

variable "private_subnet_1" {}
variable "private_subnet_2" {}