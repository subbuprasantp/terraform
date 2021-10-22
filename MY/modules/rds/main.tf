resource "null_resource" "modifydb" {
  provisioner "local-exec" {
    command = "aws rds modify-db-instance --db-instance-identifier ${var.db_identifier_name} --vpc-security-group-ids ${var.rds_security_group_api_SG} ${var.rds_security_group_core_SG} ${var.db_security_group} --apply-immediately"
  }
}