terraform {
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "5.0"
    }
  }

  backend "s3" {
    bucket = "testings-3"
    key    = "terraform-vpc_module" // file name
    region = "us-east-1"
    # dynamodb_table = "roboshop_state"   ##using dynamoDB
    encrypt      = true
    use_lockfile = true # S3 native locking
  }  
}

provider "aws" {
  region = "us-east-1"
}