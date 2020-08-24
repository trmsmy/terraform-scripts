
resource "aws_lambda_function" "lambda" {

  function_name    = var.function_name
  description = var.description
  #s3_bucket        = var.s3_bucket
  #s3_key        = var.s3_key
  filename = var.filename
  role             = var.role_arn
  handler          = var.handler
  #source_code_hash = "${data.archive_file.lambda_zip.output_base64sha256}"
  runtime          = var.runtime
  timeout           = var.timeout
  memory_size       = var.memory_size
  reserved_concurrent_executions = var.reserved_concurrent_executions

  vpc_config  {
      subnet_ids = var.subnet_ids 
      security_group_ids = var.security_group_ids 
  }

  environment  {
    variables = var.env_vars
  }
}