# provider "aws" {
#   region     = var.aws_region
#   access_key = var.AWS_ACCESS_KEY_ID
#   secret_key = var.AWS_SECRET_ACCESS_KEY
# }

terraform {
  required_providers {
    # AWS Provider Version 설정
    aws = {
      version = ">=5.70.0"
    }
  }
}
