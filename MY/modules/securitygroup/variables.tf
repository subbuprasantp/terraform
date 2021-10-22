variable in_vpc_id {
    description = "Vpc"
    type = string
}
variable "security_group_names" {
  type        = list
  description = "security group names"
}
variable location {
    description = "location"
}
variable cardup {
    description = "cardup"
}
variable "sg_alb_security_group_id" {
  description = "sg alb security group"
}
variable bastion_ec2_security_group {
    description = "bastion_ec2_security_group"
}