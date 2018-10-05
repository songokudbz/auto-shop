################################################################
## declare vars, see terraform.tfvars for actual settings
################################################################
variable "aws_profile" {}
variable "bucket_name" {}
variable "app_name" {}
variable "bucket_name_webapp" {}
variable "env" { default = "dev" }
variable "table_name_prefix" { default = "madaras" }
variable "ddb_default_wcu" { default = "1" }
variable "ddb_default_rcu" { default = "1" }
variable "aws_region" {
  default = "eu-central-1"
}

#####################################################################
## configure AWS Provide, you can use key secret here,
## but we prefer a profile in ~/.aws/credentials
#####################################################################
provider "aws" {
  profile    = "${var.aws_profile}"
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
    profile="car-shop-manager"
  }
}

#####################################################################
## create and configure S3 bucket
#####################################################################
#resource "aws_s3_bucket" "testBucket" {
#  bucket = "${var.bucket_name}"
#  acl    = "private"
#
#  tags {
#    Name        = "Terraform Test Bucket"
#    Environment = "Testing"
#    V           = "1.3"
#  }
#}

#####################################################################
## create and configure S3 bucket where we deploy our web application
#####################################################################
## see https://stackoverflow.com/questions/16267339/s3-static-website-hosting-route-all-paths-to-index-html
resource "aws_s3_bucket" "webapp" {
  bucket = "${var.bucket_name_webapp}"
  region = "${var.aws_region}"
  policy = <<EOF
{
  "Id": "bucket_policy_site",
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "bucket_policy_site_main",
      "Action": [
        "s3:GetObject"
      ],
      "Effect": "Allow",
      "Resource": "arn:aws:s3:::${var.bucket_name_webapp}/*",
      "Principal": "*"
    }
  ]
}
EOF
  website {
    index_document = "index.html"
  }
  force_destroy = true
  tags {
    Name = "${var.app_name}"
    ManagedBy = "Terraform"
  }
}

#####################################################################
## create dynamodb table(s) using our app id as prefix
#####################################################################
## main table for cars
resource "aws_dynamodb_table" "cars" {
  name           = "${var.table_name_prefix}-cars"
  read_capacity  = "${var.ddb_default_rcu}"
  write_capacity = "${var.ddb_default_wcu}"
  # (Required, Forces new resource) The attribute to use as the hash (partition) key. Must also be defined as an attribute
  hash_key       = "id"
  range_key      = "carName"
  attribute {
    name = "id"
    type = "N"
  }
  attribute {
    name = "carName"
    type = "S"
  }
  attribute {
    name = "carModel"
    type = "S"
  }
  global_secondary_index {
    name               = "carModel"
    hash_key           = "carName"
    range_key          = "carModel"
    write_capacity     = 1
    read_capacity      = 1
    projection_type    = "INCLUDE"
    non_key_attributes = ["id"]
  }
  tags {
    Name = "${var.app_name}"
    Environment = "${var.env}"
    ManagedBy = "Terraform"
  }
}
