output "alb_target_group_arn_core" {
  value = "${aws_lb_target_group.core.arn}"
}
output "alb_target_group_arn_api" {
  value = "${aws_lb_target_group.api.arn}"
}