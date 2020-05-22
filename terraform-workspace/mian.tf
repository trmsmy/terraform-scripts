provider "aws" {
  version = "~> 2.59"
  region = "us-east-2"
  shared_credentials_file = "C:\\Users\\Ramast1\\.aws\\credentials"
  profile                 = "mycloud_script"
}

resource "aws_instance" "example" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"
}

terraform {
  backend "s3" {
    bucket         = "tamilcloud-terraform-state"
    key            = "workspaces-example/terraform.tfstate"
    region         = "us-east-2"

    dynamodb_table = "terraform-state-locks"
    encrypt        = true

    shared_credentials_file = "C:\\Users\\Ramast1\\.aws\\credentials"
    profile                 = "mycloud_script"
  }
}