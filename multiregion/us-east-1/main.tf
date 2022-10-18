terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

module "child" {
  source = "../../child"
  region = var.region
}

output "web_instance_ip" {
  value = module.child.web_instance_ip
}

output "web_instance_public_dns" {
  value = module.child.web_instance_public_dns
}
