# contains packer settings, including specifying a required packer version 
# required plugins specifies all plugins required by the template to build image 
packer {
  required_plugins {
    amazon = {
      version = ">= 0.0.2"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

# source block configures a specific builder plugin 
source "amazon-ebs" "ubuntu" {
  ami_name      = "section2onboarding1"
  instance_type = "t3.micro"
  region        = "us-west-2"
  ami_regions    = ["us-west-2", "us-east-1"]
  source_ami_filter {
    filters = {
      name                = "ubuntu/images/*ubuntu-xenial-16.04-amd64-server-*"
      root-device-type    = "ebs"
      virtualization-type = "hvm"
    }
    most_recent = true
    owners      = ["099720109477"]
  }
  ssh_username = "ubuntu"
}

# build block references the amis defined by the source block above, create ubuntu image 
build {
  name    = "packerimage"
  sources = [
    "source.amazon-ebs.ubuntu"
  ]

  provisioner "shell" {
    inline = [
    "echo *** Installing apache2",
    "sudo apt-get update -y",
    "sudo apt-get install apache2 -y",
    "echo '*** Completed Installing apache2'",
    ]
  }
  }
