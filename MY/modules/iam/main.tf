resource "aws_iam_policy" "policy" {
  name        = "${var.policy_name}"
  path        = "/"
  description = "${var.policy_name}"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": [
                "s3:ListBucketByTags",
                "s3:GetLifecycleConfiguration",
                "s3:GetBucketTagging",
                "s3:GetInventoryConfiguration",
                "s3:PutAnalyticsConfiguration",
                "s3:PutAccelerateConfiguration",
                "s3:ListBucketVersions",
                "s3:GetBucketLogging",
                "s3:CreateBucket",
                "s3:GetAccelerateConfiguration",
                "s3:GetBucketPolicy",
                "s3:PutEncryptionConfiguration",
                "s3:GetEncryptionConfiguration",
                "s3:GetBucketObjectLockConfiguration",
                "s3:DeleteBucketWebsite",
                "s3:GetBucketRequestPayment",
                "s3:PutLifecycleConfiguration",
                "s3:UpdateJobPriority",
                "s3:GetMetricsConfiguration",
                "s3:DeleteBucket",
                "s3:PutBucketVersioning",
                "s3:GetBucketPublicAccessBlock",
                "s3:GetBucketPolicyStatus",
                "s3:ListBucketMultipartUploads",
                "s3:GetBucketWebsite",
                "s3:PutMetricsConfiguration",
                "s3:PutReplicationConfiguration",
                "s3:UpdateJobStatus",
                "s3:GetBucketVersioning",
                "s3:PutBucketCORS",
                "s3:GetBucketAcl",
                "s3:GetBucketNotification",
                "s3:GetReplicationConfiguration",
                "s3:PutInventoryConfiguration",
                "s3:PutBucketNotification",
                "s3:PutBucketWebsite",
                "s3:PutBucketRequestPayment",
                "s3:DescribeJob",
                "s3:PutBucketLogging",
                "s3:GetBucketCORS",
                "s3:GetAnalyticsConfiguration",
                "s3:PutBucketObjectLockConfiguration",
                "s3:GetBucketLocation"
            ],
            "Resource": [
                "arn:aws:s3:::*",
                "arn:aws:s3:*:*:job/*"
            ]
        },
        {
            "Sid": "VisualEditor1",
            "Effect": "Allow",
            "Action": [
                "s3:GetObjectRetention",
                "s3:DeleteObjectVersion",
                "s3:GetObjectVersionTagging",
                "s3:RestoreObject",
                "s3:PutObjectLegalHold",
                "s3:GetObjectLegalHold",
                "s3:ListMultipartUploadParts",
                "s3:ReplicateObject",
                "s3:GetObjectVersionTorrent",
                "s3:PutObject",
                "s3:GetObjectAcl",
                "s3:GetObject",
                "s3:GetObjectTorrent",
                "s3:AbortMultipartUpload",
                "s3:PutObjectRetention",
                "s3:GetObjectVersionAcl",
                "s3:GetObjectTagging",
                "s3:GetObjectVersionForReplication",
                "s3:DeleteObject",
                "s3:ReplicateDelete",
                "s3:GetObjectVersion"
            ],
            "Resource": "arn:aws:s3:::*/*"
        },
        {
            "Sid": "VisualEditor2",
            "Effect": "Allow",
            "Action": [
                "s3:GetAccountPublicAccessBlock",
                "s3:ListJobs",
                "s3:CreateJob"
            ],
            "Resource": "*"
        }
    ]
})
}

resource "aws_iam_user" "user" {
  name = "${var.user_name}"
}

resource "aws_iam_policy_attachment" "policy-attach" {
  name       = "policy-attachment"
  users      = [aws_iam_user.user.name]
  policy_arn = aws_iam_policy.policy.arn
}