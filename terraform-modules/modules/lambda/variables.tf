variable "function_name" {
  description = "The name of the lambda " 
  type = string 
}

variable "description" {
  description = "Description for Lambda" 
  type = string 
  default = ""
}

// variable "s3_bucket" {
//   description = "s3 bucket for lambda source/binary" 
//   type = string 
//   default = ""
// }

// variable "s3_key" {
//   description = "s3 object key for lambda source/binary" 
//   type = string 
//   default = ""
// }

variable "filename" {
 description = "file name of source from local" 
  type = string 
}

variable "role_arn" {
  description = "s3 object key for lambda source/binary" 
  type = string 
  default = ""
}

variable "handler" {
     description = "script class:method reference for lambda handler" 
  type = string 
}

variable "runtime" {
  description = "execution enviornment" 
  type = string
}


variable "timeout" {
  description = "lambda timeout in seconds" 
  type = number
  default = 30
}

variable "memory_size" {
  description = "memory_size" 
  type = number
  default = 128
}

variable "reserved_concurrent_executions" {
  description = "script class:method reference for lambda handler" 
  type = number 
  default = -1
}

variable "subnet_ids" {
  description = "subnet_ids list " 
  type = list(string)
  default = []
}

variable "security_group_ids" {
  description = "security_group_ids list" 
  type = list(string)
  default = []
}

variable "env_vars" {
  description = "env variables key,value pairs" 
  type = map(string)
  default = { DEFAULT = "DEFAULT" }
}