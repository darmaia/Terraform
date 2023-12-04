terraform {
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "~> 4.16"
    }
  }
}

provider "aws" {
    region = "us-west-2"
    profile = "jack.roper"
  
}

resource "aws_instance" "example_servder" {
    ami = "ami-04e914639d0cca79a"
    instance_type = "t2.micro"
  
    tags = {
      Name = "Teste EC2"
    }
}