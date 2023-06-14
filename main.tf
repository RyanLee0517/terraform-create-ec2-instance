provider "aws" {
  region = "ap-southeast-1"
  default_tags {
    tags = {
      Environment = "Test"
      Name        = "Jenkins"
      Managed_By  = "Terraform"
    }
  }
}

terraform {
  backend "s3" {
    bucket = "luantd"
    key    = "terraform/jenkins.tfstate"
    # dynamodb_table = "terraform-state-lock"
    region = "ap-southeast-1"
  }
}