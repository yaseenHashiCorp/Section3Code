terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }

    cloud {
    organization = "yaseen-tfcorg"
    workspaces {
      tags = [ "section3onboarding" ]
    }
  }
  }


module "aws-child" {
source = "app.terraform.io/yaseen-tfcorg/child/aws"
version = "1.0.0"
region = var.region
}

output "web_instance_ip" {
value = module.aws-child.web_instance_ip
}

output "web_instance_public_dns"{
value = module.aws-child.web_instance_public_dns
}