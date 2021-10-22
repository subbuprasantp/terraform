variable "core_ec2_names" {
  type        = string
  description = "EC2 names to be deployed"
}
variable "core_ami" {
  description = "The AMI to be deployed"
}
variable app_securitygroupid {
    description = "Vpc"
}

variable app_subnetid {
    description = "subnet"
}

variable "api_ec2_names" {
  type = string
  description = "EC2 names to be deployed"
}
variable "api_ami" {
  description = "The AMI to be deployed"
}
variable api_securitygroupid {
    description = "Vpc"
}

variable api_subnetid {
    description = "subnet"
}

variable "key_name" {
  description = "EC2 key pair"
}
variable "region" {
  description = "us-east-1"
}
variable "alb_target_group_arn_core" {
  description = "alb_target_group_arn_core"
}
variable "alb_target_group_arn_api" {
  description = "alb_target_group_arn_core"
}
variable "location" {
  description = "location where to be deployed"
}
variable "environment" {
  description = "The Deployment environment"
}