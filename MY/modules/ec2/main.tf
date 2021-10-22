resource "aws_launch_configuration" "core" {
  name = "launch_configuration_core_${var.location}"
  image_id      = "${var.core_ami}"
  instance_type = "t3.medium"
  associate_public_ip_address = false
  security_groups  = ["${var.app_securitygroupid}"]
  key_name =  "${var.key_name}"
  lifecycle {
        create_before_destroy = true
    }
  root_block_device {
      volume_size = "40"
  }
}


#########################auto scaling group##############################
resource "aws_autoscaling_group" "core" {
    name = "autoscaling_group_core_${var.location}"
    max_size = "4"
    min_size = "2"
    health_check_grace_period = 0
    health_check_type = "EC2"
    desired_capacity = 2
    force_delete = true
    launch_configuration = "${aws_launch_configuration.core.name}"
    vpc_zone_identifier = ["${var.app_subnetid}"]
    target_group_arns = ["${var.alb_target_group_arn_core}"]

    tag {
        key  = "Name"
        value = "${var.core_ec2_names}"
        propagate_at_launch = true
    }

    tag {
        key  = "Workload"
        value = "core"
        propagate_at_launch = true
    }

    tag {
        key  = "Region"
        value = "${var.location}"
        propagate_at_launch = true
    }

    tag {
        key  = "Environment"
        value = "${var.environment}"
        propagate_at_launch = true
    }
}

#####################auto scaling policy###########################
resource "aws_autoscaling_policy" "core-scale-up" {
    name = "core-scale-up_${var.location}"
    scaling_adjustment = 1
    adjustment_type = "ChangeInCapacity"
    cooldown = 0
    autoscaling_group_name = "${aws_autoscaling_group.core.name}"
}

resource "aws_autoscaling_policy" "core-scale-down" {
    name = "core-scale-down_${var.location}"
    scaling_adjustment = -1
    adjustment_type = "ChangeInCapacity"
    cooldown = 0
    autoscaling_group_name = "${aws_autoscaling_group.core.name}"
}

##################cloud alaram memory####################

resource "aws_cloudwatch_metric_alarm" "core-memory-high" {
    alarm_name = "mem-util-high-core_${var.location}"
    comparison_operator = "GreaterThanOrEqualToThreshold"
    evaluation_periods = "1"
    metric_name = "MemoryUtilization"
    namespace = "AWS/EC2"
    period = "60"
    statistic = "Average"
    threshold = "75"
    alarm_description = "This metric monitors ec2 memory for high utilization on core hosts"
    alarm_actions = [
        "${aws_autoscaling_policy.core-scale-up.arn}"
    ]
    dimensions = {
        AutoScalingGroupName = "${aws_autoscaling_group.core.name}"
    }
}

resource "aws_cloudwatch_metric_alarm" "core-memory-low" {
    alarm_name = "mem-util-low-core_${var.location}"
    comparison_operator = "LessThanOrEqualToThreshold"
    evaluation_periods = "1"
    metric_name = "MemoryUtilization"
    namespace = "AWS/EC2"
    period = "60"
    statistic = "Average"
    threshold = "50"
    alarm_description = "This metric monitors ec2 memory for low utilization on core hosts"
    alarm_actions = [
        "${aws_autoscaling_policy.core-scale-down.arn}"
    ]
    dimensions = {
        AutoScalingGroupName = "${aws_autoscaling_group.core.name}"
    }
}

##################cloud alaram cpu####################
resource "aws_cloudwatch_metric_alarm" "core-cpu-high" {
    alarm_name = "cpu-util-high-core_${var.location}"
    comparison_operator = "GreaterThanOrEqualToThreshold"
    evaluation_periods = "3"
    metric_name = "CPUUtilization"
    namespace = "AWS/EC2"
    period = "300"
    statistic = "Average"
    threshold = "85"
    alarm_description = "This metric monitors ec2 cpu for high utilization on core hosts"
    alarm_actions = [
        "${aws_autoscaling_policy.core-scale-up.arn}"
    ]
    dimensions = {
        AutoScalingGroupName = "${aws_autoscaling_group.core.name}"
    }
}

resource "aws_cloudwatch_metric_alarm" "core-cpu-low" {
    alarm_name = "cpu-util-low-core_${var.location}"
    comparison_operator = "LessThanOrEqualToThreshold"
    evaluation_periods = "3"
    metric_name = "CPUUtilization"
    namespace = "AWS/EC2"
    period = "300"
    statistic = "Average"
    threshold = "50"
    alarm_description = "This metric monitors ec2 cpu for low utilization on core hosts"
    alarm_actions = [
        "${aws_autoscaling_policy.core-scale-down.arn}"
    ]
    dimensions = {
        AutoScalingGroupName = "${aws_autoscaling_group.core.name}"
    }
}

###########################API####################################
###################################################################


resource "aws_launch_configuration" "api" {
  name = "launch_configuration_api_${var.location}"
  image_id      = "${var.api_ami}"
  instance_type = "t3.medium"
  associate_public_ip_address = false
  security_groups  = ["${var.api_securitygroupid}"]
  key_name =  "${var.key_name}"
  lifecycle {
        create_before_destroy = true
    }
  root_block_device {
      volume_size = "40"
  }
}

#########################auto scaling group##############################
resource "aws_autoscaling_group" "api" {
    name = "autoscaling_group_api_${var.location}"
    max_size = "4"
    min_size = "2"
    health_check_grace_period = 0
    health_check_type = "EC2"
    desired_capacity = 2
    force_delete = true
    launch_configuration = "${aws_launch_configuration.api.name}"
    vpc_zone_identifier = ["${var.app_subnetid}"]
    target_group_arns = ["${var.alb_target_group_arn_api}"]

    tag {
        key  = "Name"
        value = "${var.api_ec2_names}"
        propagate_at_launch = true
    }

    tag {
        key  = "Workload"
        value = "api"
        propagate_at_launch = true
    }

    tag {
        key  = "Region"
        value =  "${var.location}"
        propagate_at_launch = true
    }

    tag {
        key  = "Environment"
        value = "${var.environment}"
        propagate_at_launch = true
    }
}

#####################auto scaling policy###########################
resource "aws_autoscaling_policy" "api-scale-up" {
    name = "api-scale-up_${var.location}"
    scaling_adjustment = 1
    adjustment_type = "ChangeInCapacity"
    cooldown = 0
    autoscaling_group_name = "${aws_autoscaling_group.api.name}"
}

resource "aws_autoscaling_policy" "api-scale-down" {
    name = "api-scale-down_${var.location}"
    scaling_adjustment = -1
    adjustment_type = "ChangeInCapacity"
    cooldown = 0
    autoscaling_group_name = "${aws_autoscaling_group.api.name}"
}

##################cloud alaram memory####################

resource "aws_cloudwatch_metric_alarm" "api-memory-high" {
    alarm_name = "mem-util-high-api_${var.location}"
    comparison_operator = "GreaterThanOrEqualToThreshold"
    evaluation_periods = "1"
    metric_name = "MemoryUtilization"
    namespace = "AWS/EC2"
    period = "60"
    statistic = "Average"
    threshold = "75"
    alarm_description = "This metric monitors ec2 memory for high utilization on api hosts"
    alarm_actions = [
        "${aws_autoscaling_policy.api-scale-up.arn}"
    ]
    dimensions = {
        AutoScalingGroupName = "${aws_autoscaling_group.api.name}"
    }
}

resource "aws_cloudwatch_metric_alarm" "api-memory-low" {
    alarm_name = "mem-util-low-api_${var.location}"
    comparison_operator = "LessThanOrEqualToThreshold"
    evaluation_periods = "1"
    metric_name = "MemoryUtilization"
    namespace = "AWS/EC2"
    period = "60"
    statistic = "Average"
    threshold = "50"
    alarm_description = "This metric monitors ec2 memory for low utilization on api hosts"
    alarm_actions = [
        "${aws_autoscaling_policy.api-scale-down.arn}"
    ]
    dimensions = {
        AutoScalingGroupName = "${aws_autoscaling_group.api.name}"
    }
}

##################cloud alaram cpu####################
resource "aws_cloudwatch_metric_alarm" "api-cpu-high" {
    alarm_name = "cpu-util-high-api_${var.location}"
    comparison_operator = "GreaterThanOrEqualToThreshold"
    evaluation_periods = "3"
    metric_name = "CPUUtilization"
    namespace = "AWS/EC2"
    period = "300"
    statistic = "Average"
    threshold = "85"
    alarm_description = "This metric monitors ec2 cpu for high utilization on api hosts"
    alarm_actions = [
        "${aws_autoscaling_policy.api-scale-up.arn}"
    ]
    dimensions = {
        AutoScalingGroupName = "${aws_autoscaling_group.api.name}"
    }
}

resource "aws_cloudwatch_metric_alarm" "api-cpu-low" {
    alarm_name = "cpu-util-low-api_${var.location}"
    comparison_operator = "LessThanOrEqualToThreshold"
    evaluation_periods = "3"
    metric_name = "CPUUtilization"
    namespace = "AWS/EC2"
    period = "300"
    statistic = "Average"
    threshold = "50"
    alarm_description = "This metric monitors ec2 cpu for low utilization on api hosts"
    alarm_actions = [
        "${aws_autoscaling_policy.api-scale-down.arn}"
    ]
    dimensions = {
        AutoScalingGroupName = "${aws_autoscaling_group.api.name}"
    }
}