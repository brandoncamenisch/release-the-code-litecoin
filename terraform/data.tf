data "aws_caller_identity" "iam" {}

data "aws_caller_identity" "production" {
  provider = "aws.production"
}