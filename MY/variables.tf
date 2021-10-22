variable "region" {
  description = "us-east-1"
}
variable "location" {
  description = "location where to be deployed"
}
variable "cardup" {
  description = "CU"
}
variable "environment" {
  description = "The Deployment environment"
}
variable "core_public_subnets_cidr" {
  type        = list
  description = "The CIDR block for the public subnet"
}
variable "core_private_subnets_cidr" {
  type        = list
  description = "The CIDR block for the private subnet"
}
variable "core_public_subnet_name" {
  description = "Public subnet name"
}
variable "core_private_subnet_name" {
  description = "Public subnet name"
}
variable "core_ec2_name" {
  type        = string
  description = "EC2 names to be deployed"
}
variable "core_ami" {
  description = "The AMI to be deployed"
}
variable "alb_name" {
  description = "Name of the ALB"
}
variable "api_public_subnet_name" {
  description = "APi public subnet name"
}
variable "api_private_subnet_name" {
  description = "APi public subnet name"
}
variable "api_public_subnets_cidr" {
  type        = list
  description = "The CIDR block for the api public subnet"
}
variable "api_private_subnets_cidr" {
  type        = list
  description = "The CIDR block for the api private subnet"
}
variable "api_ec2_name" {
  type = string
  description = "EC2 names to be deployed"
}
variable "api_ami" {
  description = "The AMI to be deployed"
}
variable "key_name" {
  description = "EC2 key pair"
}
variable "s3_bucket_name" {
  description = "S3 bucket name"
}
variable "policy_name" {
  description = "iam policy name"
}
variable "user_name" {
  description = "iam user name"
}
variable "security_group_names" {
  type        = list
  description = "security group names"
}
variable "aws_cognito_user_pool_name" {
  description = "cognito user pool name"
}
variable "cognito_identifier" {
    description = "identifier name"
}
variable "aws_cognito_user_pool_client" {
    description = "aws_cognito_user_pool_client name"
}
variable "core_domain_name" {
  description = "core domain name"
}
variable "api_domain_name" {
  description = "api domain name"
}
variable "s3_logs_bucket_name" {
  description = "S3 bucket name"
}
variable "admin_domain_name" {
  description = "admin domain name"
}