resource "aws_s3_bucket" "this" {
  bucket        = var.bucket_name
  force_destroy = var.force_destroy
}

resource "aws_s3_bucket_policy" "allow_vpc_endpoint" {
  bucket = aws_s3_bucket.this.bucket
  policy = data.aws_iam_policy_document.s3_vpc_endpoint_policy.json
}

data "aws_iam_policy_document" "s3_vpc_endpoint_policy" {
  statement {
    actions = ["s3:*"]
    resources = [
      aws_s3_bucket.this.arn,
      "${aws_s3_bucket.this.arn}/*"
    ]
    principals {
      type        = "AWS"
      identifiers = ["*"]
    }
    condition {
      test     = "StringEquals"
      variable = "aws:sourceVpce"
      values   = [var.vpce_id]
    }
  }
}