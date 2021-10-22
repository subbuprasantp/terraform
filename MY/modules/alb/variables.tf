variable "alb_name" {
  description = "Name of the ALB"
}
variable alb_listener_arn {
    description = "ALB LISTENER ARN"
}
variable "vpc_id" {
    description = "ALB vpc id"
}

variable "core_domain_name" {
  description = "core domain name"
}

variable "api_domain_name" {
  description = "api domain name"
}
variable "admin_domain_name" {
  description = "admin domain name"
}
variable alb_listener_arn_https {
    description = "ALB LISTENER ARN HTTPS"
}