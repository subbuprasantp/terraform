region                         = "ap-southeast-1"
environment                    = "ST"
location                       = "MY"
cardup                         = "CU"
#######################SUBNETS####################
core_public_subnets_cidr       = ["10.0.12.0/24","10.0.14.0/24"]
core_private_subnets_cidr      = ["10.0.11.0/24"]
core_public_subnet_name        = "PublicAppSub"
core_private_subnet_name       = "PrivateAppSub"
api_public_subnets_cidr        = ["10.0.16.0/24"]
api_private_subnets_cidr       = ["10.0.13.0/24"]
api_public_subnet_name         = "PublicApiSub"
api_private_subnet_name        = "PrivateApiSub"
######################EC2#########################
core_ec2_name                  = "CoreApp"
core_ami                       = "ami-0fb588b1b30b6bf29"
api_ec2_name                   = "APIApp"
api_ami                        = "ami-03736ba82d5dafeb0" 
key_name                       = "StagingStarter"
security_group_names           = ["WApp1","WDB1","WAPI1","WAPIDB1"]
#######################ALB#######################
alb_name                       = "WWW1"
core_domain_name               = "mycorestaging.cardup.global"
api_domain_name                = "api.test.com"
admin_domain_name              = "myadminstaging.cardup.global"
#######################S3#######################
s3_bucket_name                 = "generic"
s3_logs_bucket_name            = "logs"
#######################IAM#######################
policy_name                    = "GenericPolicy"
user_name                      = "GenericUser"
#######################COGNITO#######################
aws_cognito_user_pool_name     = "oauth2"
cognito_identifier             = "CollectAPI"
aws_cognito_user_pool_client   = "Client"