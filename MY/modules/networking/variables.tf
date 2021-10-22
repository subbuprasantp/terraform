variable "environment" {
  description = "The Deployment environment"
}

variable "vpc_id" {
  description = "vpc id"
}

variable "core_public_subnets_cidr" {
  type        = list
  description = "The CIDR block for the public subnet"
}

variable "core_private_subnets_cidr" {
  type        = list
  description = "The CIDR block for the private subnet"
}

variable "region" {
  description = "The region to launch the bastion host"
}

variable "availability_zones" {
  type        = list
  description = "The az that the resources will be launched"
}


variable "core_public_subnet_name" {
  description = "Public subnet name"
}
variable "core_private_subnet_name" {
  description = "Public subnet name"
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
variable "public_routable_id" {
  description = "public routable id"
}

variable "private_routable_id" {
  description = "private routable id"
}