resource "random_id" "random_id_prefix" {
  byte_length = 2
}

data "terraform_remote_state" "sg" {
  backend = "s3"
  config = {
    bucket = "terraformcardupbackend"
    key    = "SG.tfstate"
    region = "ap-southeast-1"
  }
}

locals {
  availability_zones = ["${var.region}a", "${var.region}b", "${var.region}c"]
}
module "networking" {
  source = "./modules/networking"

  region               = "${var.region}"
  environment          = "${var.environment}"
  core_public_subnets_cidr  = "${var.core_public_subnets_cidr}"
  core_private_subnets_cidr = "${var.core_private_subnets_cidr}"
  availability_zones   = "${local.availability_zones}"
  vpc_id             = "${data.terraform_remote_state.sg.outputs.vpc_id}"
  core_public_subnet_name   = "${var.cardup}${var.location}${var.environment}${var.core_public_subnet_name}"
  core_private_subnet_name  = "${var.cardup}${var.location}${var.environment}${var.core_private_subnet_name}"
  api_public_subnets_cidr  = "${var.api_public_subnets_cidr}"
  api_private_subnets_cidr = "${var.api_private_subnets_cidr}"
  api_public_subnet_name   = "${var.cardup}${var.location}${var.environment}${var.api_public_subnet_name}"
  api_private_subnet_name  = "${var.cardup}${var.location}${var.environment}${var.api_private_subnet_name}"
  public_routable_id  = "${data.terraform_remote_state.sg.outputs.public_routable_id}"
  private_routable_id  = "${data.terraform_remote_state.sg.outputs.private_routable_id}"
}

module "securitygroup" {
  source = "./modules/securitygroup"
  
  security_group_names = "${var.security_group_names}"
  in_vpc_id = "${data.terraform_remote_state.sg.outputs.vpc_id}"
  location = "${var.location}"
  cardup = "${var.cardup}"
  sg_alb_security_group_id = "${data.terraform_remote_state.sg.outputs.alb_security_group}"
  bastion_ec2_security_group = "${data.terraform_remote_state.sg.outputs.bastion_ec2_security_group}"
}

module "ec2" {
  source = "./modules/ec2"

  core_ec2_names            = "${var.cardup}${var.location}${var.environment}${var.core_ec2_name}"
  core_ami                  = "${var.core_ami}"
  app_securitygroupid      = module.securitygroup.app_ec2_security_group
  app_subnetid             = flatten(module.networking.app_private_subnets_id)[0]
  api_ec2_names            = "${var.cardup}${var.location}${var.environment}${var.api_ec2_name}"
  api_ami                  = "${var.api_ami}"
  api_securitygroupid      = module.securitygroup.api_ec2_security_group
  api_subnetid             = flatten(module.networking.api_private_subnets_id)[0]
  key_name                 = "${var.key_name}"
  region               = "${var.region}"
  alb_target_group_arn_core = module.alb.alb_target_group_arn_core
  alb_target_group_arn_api = module.alb.alb_target_group_arn_api
  environment                   = "${var.environment}"
  location                       = "${var.location}" 
}

module "rds" {
  source = "./modules/rds"

  rds_security_group_api_SG    = "${data.terraform_remote_state.sg.outputs.rds_security_group_api}"
  rds_security_group_core_SG   = "${data.terraform_remote_state.sg.outputs.rds_security_group_core}"
  db_identifier_name           = "${data.terraform_remote_state.sg.outputs.db_identifier_name}"
  db_security_group            = module.securitygroup.db_security_group
}

module "S3" {
  source = "./modules/S3"

  region               = "${var.region}"
  s3_bucket_name       = lower("${var.cardup}${var.location}${var.environment}-${var.s3_bucket_name}")
  s3_logs_bucket_name  = lower("${var.cardup}${var.location}${var.environment}-${var.s3_logs_bucket_name}")
}

module "iam" {
  source = "./modules/iam"
  
  policy_name = "${var.cardup}${var.location}${var.environment}${var.policy_name}"
  user_name = "${var.cardup}${var.location}${var.environment}${var.user_name}"
}

module "alb" {
  source = "./modules/alb"
  
  alb_name = "${var.cardup}${var.location}${var.alb_name}"
  alb_listener_arn = "${data.terraform_remote_state.sg.outputs.alb_listener_arn}" 
  alb_listener_arn_https = "${data.terraform_remote_state.sg.outputs.alb_listener_arn_https}" 
  vpc_id = "${data.terraform_remote_state.sg.outputs.vpc_id}"
  core_domain_name = "${var.core_domain_name}"
  api_domain_name = "${var.api_domain_name}"
  admin_domain_name = "${var.admin_domain_name}"
}

module "cognito" {
  source = "./modules/cognito"

  aws_cognito_user_pool_client = "${var.cardup}${var.location}${var.environment}${var.aws_cognito_user_pool_client}" 
  cognito_identifier = "${var.cardup}${var.location}${var.environment}${var.cognito_identifier}"
  aws_cognito_user_pool_name = "${var.cardup}${var.location}${var.environment}_${var.aws_cognito_user_pool_name}"
}