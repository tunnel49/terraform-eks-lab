terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 3.42"
    }
  }

  required_version = ">=0.15.4"
}

provider "aws" {
  region = "eu-west-1"
  profile = "910881736194_Administrator"
}

data "aws_availability_zones" "available" {
  state = "available"
}

resource "aws_vpc" "eks_vpc1" {
  cidr_block = "10.101.0.0/16"
  tags = {
    name = "tunnel49 lab"
  }
}

resource "aws_subnet" "eks_subnet1" {
  count = 3
  vpc_id = aws_vpc.eks_vpc1.id
  availability_zone = data.aws_availability_zones.available.names[count.index]
  cidr_block = cidrsubnet(aws_vpc.eks_vpc1.cidr_block, 2, count.index)

  tags = {
    name = "tunnel49 lab"
  }
}
