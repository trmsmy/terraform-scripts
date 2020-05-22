provider "aws" {
  region = "us-east-2"
  version = "~> 2.59"
  shared_credentials_file = "C:\\Users\\Ramast1\\.aws\\credentials"
  profile                 = "mycloud_script"
}
 
terraform {
  backend "s3" {
    bucket         = "tamilcloud-terraform-state"
    key            = "global/s3/terraform.tfstate"
    region         = "us-east-2"

    dynamodb_table = "terraform-state-locks"
    encrypt        = true

    shared_credentials_file = "C:\\Users\\Ramast1\\.aws\\credentials"
    profile                 = "mycloud_script"
  }
}

resource "aws_s3_bucket" "terraform_state" {
    bucket = "tamilcloud-terraform-state" 

    versioning {
        enabled = true 
    }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}


resource "aws_dynamodb_table" "terraform_locks" {
  name = "terraform-state-locks"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}


output "dynamodb_table_name" {
  value       = aws_dynamodb_table.terraform_locks.name
  description = "The name of the DynamoDB table"
}