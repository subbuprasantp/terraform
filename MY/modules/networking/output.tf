
output "public_subnets_id" {
  value = ["${aws_subnet.public_subnet.*.id}"]
}

output "app_private_subnets_id" {
  value = ["${aws_subnet.private_subnet.*.id}"]
}
output "api_private_subnets_id" {
  value = ["${aws_subnet.api_private_subnet.*.id}"]
}