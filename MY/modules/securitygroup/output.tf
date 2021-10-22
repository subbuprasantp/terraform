output "app_ec2_security_group" {
  value = "${aws_security_group.groups.0.id}"
}

output "api_ec2_security_group" {
  value = "${aws_security_group.groups.2.id}"
}

output "db_security_group" {
  value = "${aws_security_group.groups.1.id}"
}