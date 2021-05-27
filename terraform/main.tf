terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 3.27"
    }
  }

  required_version = ">=0.14.9"
}

provider "aws" {
  region = "eu-west-1"
  profile = "910881736194_Administrator"
}

resource "aws_vpc" "eks_vpc1" {
  cidr_block = "10.101.0.0/16"
  tags = {
    name = "tunnel49 lab"
  }
}

resource "aws_subnet" "eks_subnet1" {
  vpc_id = aws_vpc.eks_vpc1.id
  cidr_block = "10.101.0.0/20"
  tags = {
    name = "tunnel49 lab"
  }
}
