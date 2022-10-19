# Configure the AWS Provider
provider "aws" {
  region = "us-west-2"
  shared_credentials_file = var.creds
  profile = "default"
}

# Create a VPC
resource "aws_vpc" "app_vpc" {
  cidr_block = var.vpc_cidr

  tags = {
    Name = "app-vpc"
  }
}

#vpc internet gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.app_vpc.id

  tags = {
    Name = "vpc_igw"
  }
}

#vpc subnet
resource "aws_subnet" "public_subnet" {
  vpc_id            = aws_vpc.app_vpc.id
  cidr_block        = var.public_subnet_cidr
  map_public_ip_on_launch = true
  availability_zone = "us-west-2b"

  tags = {
    Name = "public-subnet"
  }
}

#vpc routing table
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.app_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "public_rt"
  }
}

#ec2 association between route table and subnet
resource "aws_route_table_association" "public_rt_asso" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_rt.id
}


#Create key-pair for logging into EC2 in desired server

resource "tls_private_key" "example" {
  algorithm = "RSA"
}
resource "aws_key_pair" "generated_keysec3" {
  key_name   = "generated_keysec3"
  public_key = tls_private_key.example.public_key_openssh
}

# Create and bootstrap webserver
resource "aws_instance" "web" {
  ami                         = "ami-0ee79517b715ee611"
  instance_type               = "t3.micro"
  key_name                    = aws_key_pair.generated_keysec3.key_name
  associate_public_ip_address = true
  security_groups             = [aws_security_group.sg.id]
  subnet_id                   = aws_subnet.public_subnet.id

connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = tls_private_key.example.private_key_pem
      host        = self.public_ip
    }
}