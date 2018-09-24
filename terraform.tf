################################################################
## declare vars, see terraform.tfvars for actual settings
################################################################
variable "access_key" {}
variable "secret_key" {}
variable "bucket_name" {}
variable "aws_region" {
  default = "eu-central-1"
}

#####################################################################
## configure AWS Provide, you can use key secret here,
## but we prefer a profile in ~/.aws/credentials
#####################################################################
provider "aws" {
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
  region     = "${var.aws_region}"
}

#####################################################################
## Terraform config
#####################################################################
terraform {
  backend "s3" {
    bucket="madaras-terraform-state"
    key="terraform.tfstate"
    region="eu-central-1"
  }
}

#####################################################################
## create and configure S3 bucket
#####################################################################
resource "aws_s3_bucket" "testBucket" {
  bucket = "${var.bucket_name}"
  acl    = "private"

  tags {
    Name        = "Terraform Test Bucket"
    Environment = "Testing"
    V           = "1.3"
  }
}
