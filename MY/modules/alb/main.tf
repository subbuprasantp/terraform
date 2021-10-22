resource "aws_lb_target_group" "core" {
  name     = "${var.alb_name}-core-my"
  port     = 80
  protocol = "HTTP"
  vpc_id   = "${var.vpc_id}"
 health_check {
    path = "/referafriend.jpg"
    healthy_threshold = 5
    unhealthy_threshold = 2
    timeout = 5
    interval = 30
    matcher = "200,301"
  }
}

resource "aws_lb_target_group" "api" {
  name     = "${var.alb_name}-api-my"
  port     = 80
  protocol = "HTTP"
  vpc_id   = "${var.vpc_id}"
}

resource "aws_lb_listener_rule" "host_based_routing" {
  listener_arn = "${var.alb_listener_arn}"
  priority     = 96

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.core.arn
  }

  condition {
    host_header {
      values = ["${var.core_domain_name}"]
    }
  }
}

resource "aws_lb_listener_rule" "host_based_routing_admin" {
  listener_arn = "${var.alb_listener_arn}"
  priority     = 97

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.core.arn
  }

  condition {
    host_header {
      values = ["${var.admin_domain_name}"]
    }
  }
}

###################HTTPS RULE################################
resource "aws_lb_listener_rule" "host_based_routing_https" {
  listener_arn = "${var.alb_listener_arn_https}"
  priority     = 96

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.core.arn
  }

  condition {
    host_header {
      values = ["${var.core_domain_name}"]
    }
  }
}

resource "aws_lb_listener_rule" "host_based_routing_admin_https" {
  listener_arn = "${var.alb_listener_arn_https}"
  priority     = 97

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.core.arn
  }

  condition {
    host_header {
      values = ["${var.admin_domain_name}"]
    }
  }
}
# resource "aws_lb_listener_rule" "host_based_routing_api" {
#   listener_arn = "${var.alb_listener_arn}"
#   priority     = 97

#   action {
#     type             = "forward"
#     target_group_arn = aws_lb_target_group.api.arn
#   }

#   condition {
#     host_header {
#       values = ["${var.api_domain_name}"]
#     }
#   }
# }