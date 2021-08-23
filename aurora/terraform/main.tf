provider "aws" {}

data "aws_caller_identity" "caller_identity" {}

data "aws_vpc" "selected" {
  id = var.vpc_id
}

variable "aws_region" {}

variable "database_user" {}

variable "vpc_id" {}