terraform {
  #backend "s3" {
  #  bucket = "terraform-state-0235"
  #  key    = "ec2-project/terraform.tfstate"
  #  region = "ap-southeast-1"
  #}
}

provider "aws" {
  region = "ap-southeast-1"
}