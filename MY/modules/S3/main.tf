
resource "aws_s3_bucket" "log_bucket" {
  bucket = "${var.s3_logs_bucket_name}"
  acl    = "log-delivery-write"
    server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = aws_kms_key.mykey.arn
        sse_algorithm     = "aws:kms"
      }
    }
  }

}
resource "aws_kms_key" "mykey" {
  description             = "This key is used to encrypt bucket objects and created by terraform"
  deletion_window_in_days = 10
  enable_key_rotation = true
  tags = {
      name      = "s3_enryption"
      description = "created by terraform"
    }
}

resource "aws_kms_alias" "alias" {
  name          = "alias/${var.s3_bucket_name}"
  target_key_id = aws_kms_key.mykey.key_id
}

resource "aws_s3_bucket" "my" {
  bucket = "${var.s3_bucket_name}"
  acl    = "private"

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = aws_kms_key.mykey.arn
        sse_algorithm     = "aws:kms"
      }
    }
  }

  logging {
    target_bucket = aws_s3_bucket.log_bucket.id
    target_prefix = "log/"
  }

  lifecycle_rule {
    id      = "log"
    enabled = true

    prefix = "/"

    tags = {
      rule      = "log"
      autoclean = "true"
    }

    transition {
      days          = 180
      storage_class = "STANDARD_IA" # or "ONEZONE_IA"
    }

    transition {
      days          = 360
      storage_class = "GLACIER"
    }
  }

  tags = {
    Name        = "${var.s3_bucket_name}"
    Environment = "${var.region}"
  }
}