######################security groups###################
resource aws_security_group groups {

    vpc_id      = "${var.in_vpc_id}"
    count       = "${length(var.security_group_names)}"
    name        = "${var.cardup}${var.location}F${element(var.security_group_names, count.index)}"
    # description = "This new security group ${ var.in_description }"
    tags = {
      Name = "${var.cardup}${var.location}F${element(var.security_group_names, count.index)}"
  }
}

resource aws_security_group_rule ingress_http_app {

    security_group_id = aws_security_group.groups.0.id

    type        = "ingress"
    source_security_group_id ="${var.sg_alb_security_group_id}"
    description = "Traffic from ALB"

    from_port = "80"
    to_port   = "80"
    protocol  = "TCP"
}

resource aws_security_group_rule ingress_redis_app {

    security_group_id = aws_security_group.groups.0.id

    type        = "ingress"
    source_security_group_id = aws_security_group.groups.0.id
    description = "Inbound Redis"

    from_port = "6379"
    to_port   = "6379"
    protocol  = "TCP"
}

resource aws_security_group_rule egress_http_app {

    security_group_id = aws_security_group.groups.0.id

    type        = "egress"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Outbound http"

    from_port = "80"
    to_port   = "80"
    protocol  = "TCP"
}

resource aws_security_group_rule egress_redis_app {

    security_group_id = aws_security_group.groups.0.id

    type        = "egress"
    source_security_group_id = aws_security_group.groups.0.id
    description = "Outbound Redis"

    from_port = "6379"
    to_port   = "6379"
    protocol  = "TCP"
}

resource aws_security_group_rule egress_https_app {

    security_group_id = aws_security_group.groups.0.id

    type        = "egress"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Outbound https"

    from_port = "443"
    to_port   = "443"
    protocol  = "TCP"
}

resource aws_security_group_rule egress_ssh_app {

    security_group_id = aws_security_group.groups.0.id

    type        = "egress"
    cidr_blocks = ["0.0.0.0/0"]
    description = "For Git "

    from_port = "22"
    to_port   = "22"
    protocol  = "TCP"
}

resource aws_security_group_rule egress_mysql_app {

    security_group_id = aws_security_group.groups.0.id

    type        = "egress"
    source_security_group_id = aws_security_group.groups.1.id
    description = "Outbound MySQL"

    from_port = "3306"
    to_port   = "3306"
    protocol  = "TCP"
}

resource aws_security_group_rule ingress_mysql_db {

    security_group_id = aws_security_group.groups.1.id

    type        = "ingress"
    source_security_group_id = aws_security_group.groups.0.id
    description = "Inbound MySQL"

    from_port = "3306"
    to_port   = "3306"
    protocol  = "TCP"
}

resource aws_security_group_rule egress_http_db {

    security_group_id = aws_security_group.groups.1.id

    type        = "egress"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Outbound http"

    from_port = "80"
    to_port   = "80"
    protocol  = "TCP"
}

resource aws_security_group_rule egress_https_db {

    security_group_id = aws_security_group.groups.1.id

    type        = "egress"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Outbound https"

    from_port = "443"
    to_port   = "443"
    protocol  = "TCP"
}

resource aws_security_group_rule ingress_http_api {

    security_group_id = aws_security_group.groups.2.id

    type        = "ingress"
    source_security_group_id ="${var.sg_alb_security_group_id}"
    description = "Traffic from ALB"

    from_port = "80"
    to_port   = "80"
    protocol  = "TCP"
}

resource aws_security_group_rule egress_http_api {

    security_group_id = aws_security_group.groups.2.id

    type        = "egress"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Outbound http"

    from_port = "80"
    to_port   = "80"
    protocol  = "TCP"
}

resource aws_security_group_rule egress_https_api {

    security_group_id = aws_security_group.groups.2.id

    type        = "egress"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Outbound https"

    from_port = "443"
    to_port   = "443"
    protocol  = "TCP"
}

resource aws_security_group_rule egress_ssh_api {

    security_group_id = aws_security_group.groups.2.id

    type        = "egress"
    cidr_blocks = ["0.0.0.0/0"]
    description = "For Git "

    from_port = "22"
    to_port   = "22"
    protocol  = "TCP"
}

resource aws_security_group_rule egress_mysql_api {

    security_group_id = aws_security_group.groups.2.id

    type        = "egress"
    source_security_group_id = aws_security_group.groups.3.id
    description = "Outbound MySQL"

    from_port = "3306"
    to_port   = "3306"
    protocol  = "TCP"
}

resource aws_security_group_rule ingress_mysql_apidb {

    security_group_id = aws_security_group.groups.3.id

    type        = "ingress"
    source_security_group_id = aws_security_group.groups.2.id
    description = "Inbound MySQL"

    from_port = "3306"
    to_port   = "3306"
    protocol  = "TCP"
}

resource aws_security_group_rule egress_http_apidb {

    security_group_id = aws_security_group.groups.3.id

    type        = "egress"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Outbound http"

    from_port = "80"
    to_port   = "80"
    protocol  = "TCP"
}

resource aws_security_group_rule egress_https_apidb {

    security_group_id = aws_security_group.groups.3.id

    type        = "egress"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Outbound https"

    from_port = "443"
    to_port   = "443"
    protocol  = "TCP"
}
resource aws_security_group_rule ingress_bastion {

    security_group_id = aws_security_group.groups.0.id

    type        = "ingress"
    source_security_group_id = "${var.bastion_ec2_security_group}"
    description = "Bastion"

    from_port = "22"
    to_port   = "22"
    protocol  = "TCP"
}

resource aws_security_group_rule egress_ssh_core_bastion {

    security_group_id = "${var.bastion_ec2_security_group}"

    type        = "egress"
    source_security_group_id = aws_security_group.groups.0.id
    description = "${var.location} CORE"

    from_port = "22"
    to_port   = "22"
    protocol  = "TCP"
}
resource aws_security_group_rule http_egress_alb_app {

    security_group_id = "${var.sg_alb_security_group_id}"

    type        = "egress"
    source_security_group_id = aws_security_group.groups.0.id
    description = "${var.location} FW APP 1"

    from_port = "80"
    to_port   = "80"
    protocol  = "TCP"
}