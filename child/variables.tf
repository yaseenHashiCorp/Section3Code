variable "region" {            default                   = "us-west-2"}
variable "key_name"{           default                   = "section2keypair"}
variable "instance_type" {     default                   = "t3.micro"}
variable "creds" {             default                   = "~/.aws/credentials"}
variable "instance_key" {      default                   = "section2keypair" }
variable "vpc_cidr" {          default                   = "178.0.0.0/16"}
variable "public_subnet_cidr" {default                   = "178.0.10.0/24"}
variable "prefix" {            description = "This is the environment where your webapp is deployed. qa, prod, or dev" }