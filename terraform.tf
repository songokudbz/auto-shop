################################################################
## declare vars, see terraform.tfvars for actual settings
################################################################
variable "bucket_name" {}
variable "aws_region" {
  default = "eu-central-1"
}

#####################################################################
## configure AWS Provide, you can use key secret here,
## but we prefer a profile in ~/.aws/credentials
#####################################################################
provider "aws" {
  region     = "${var.aws_region}"
}

#####################################################################
## create and configure S3 bucket
#####################################################################
resource "aws_s3_bucket" "testBucket" {
  bucket = "${var.bucket_name}"
  acl    = "private"

  tags {
    Name            = "Terraform Test Bucket"
    Environment = "Test"
  }
}