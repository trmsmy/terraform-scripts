provider "aws" {
  version = "~> 2.59"
  region                  = "us-east-1"
  shared_credentials_file = "~/.aws/credentials"
  profile                 = "myawscloud"
}

data "archive_file" "lambda_zip" {
    type          = "zip"
    source_file   = "index.js"
    output_path   = "lambda_function.zip"
}

module "lambda_processor" {
  source = "../../modules/lambda"
  function_name = "lambda_processor"
  filename = "lambda_function.zip"
  handler = "index.handler" 
  runtime = "nodejs12.x"
  role_arn = "arn:aws:iam::663728953878:role/labcorp-lpk-sandbox-lambda-orders-processors-role"

  env_vars =  tomap({"aaaaaaa" = "foo", "aaaa_bbbb" = true})
}

 

