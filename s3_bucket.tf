data "aws_caller_identity" "current" {}

#https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket
resource "aws_s3_bucket" "artifacts" {
  bucket        = "${data.aws_caller_identity.current.account_id}-${var.name}-artifacts"
  force_destroy = true

  #checkov:skip=CKV_AWS_18: AWS Access logging not enabled on S3 buckets
  #checkov:skip=CKV2_AWS_61: An S3 bucket must have a lifecycle configuration
  #Above rules are for deprecated properties.

  #checkov:skip=CKV_AWS_144: S3 bucket cross-region replication disabled
  #This bucket is used for storing access logs for the load balancer, and does not require another bucket to store this bucket's access logs.

  #checkov:skip=CKV_AWS_21: AWS S3 Object Versioning is disabled
  #The items in this S3 bucket do not require versioning.

  #checkov:skip=CKV2_AWS_62: S3 buckets do not have event notifications enabled
  #The items in this s3 bucket are access logs and do not require any event notifications to be sent anywhere.

  #checkov:skip=CKV_AWS_145: Ensure that S3 buckets are encrypted with KMS by default
  #The only server-side encryption option that's supported is Amazon S3-managed keys (SSE-S3)
  #This bucket is already encrypted below using SSE-S3.
  #resource "aws_s3_bucket_server_side_encryption_configuration" "encrypt_bucket" {}
}

#https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_public_access_block
resource "aws_s3_bucket_public_access_block" "artifacts" {
  bucket                  = aws_s3_bucket.artifacts.id
  block_public_acls       = true
  block_public_policy     = true
  restrict_public_buckets = true
  ignore_public_acls      = true
}

#https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_server_side_encryption_configuration
resource "aws_s3_bucket_server_side_encryption_configuration" "encrypt_bucket" {
  bucket = aws_s3_bucket.artifacts.bucket
  rule {
    apply_server_side_encryption_by_default {
      #The only server-side encryption option that's supported is Amazon S3-managed keys (SSE-S3) 
      #https://docs.aws.amazon.com/elasticloadbalancing/latest/application/enable-access-logging.html#access-log-create-bucket
      sse_algorithm = "AES256"
    }
  }
}
#https://docs.aws.amazon.com/elasticloadbalancing/latest/application/enable-access-logging.html#attach-bucket-policy
#https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_policy
resource "aws_s3_bucket_policy" "alb_logs" {
  bucket = aws_s3_bucket.artifacts.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid      = "AllowELBRootAccount"
        Effect   = "Allow"
        Action   = "s3:PutObject"
        Resource = "${aws_s3_bucket.artifacts.arn}/*"
        Principal = {
          AWS = "arn:aws:iam::033677994240:root" # us-east-2 ELB account
        }
      }
    ]
  })
}
