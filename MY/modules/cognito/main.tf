resource "aws_cognito_user_pool" "pool" {
  name = "${var.aws_cognito_user_pool_name}"
}
resource "aws_cognito_resource_server" "resource" {
  identifier = "${var.cognito_identifier}"
  name       = "CollectAPI"
  scope {
    scope_name        = "get"
    scope_description = "get_txn"
  }
    scope {
    scope_name        = "post"
    scope_description = "post_txn"
  }

  user_pool_id = aws_cognito_user_pool.pool.id
}
resource "aws_cognito_user_pool_client" "client" {
  name = "${var.aws_cognito_user_pool_client}"

  user_pool_id = aws_cognito_user_pool.pool.id
  allowed_oauth_flows = ["client_credentials"]
  allowed_oauth_flows_user_pool_client = true
  allowed_oauth_scopes  = ["${var.cognito_identifier}/post", "${var.cognito_identifier}/get"]
  generate_secret     = true
}