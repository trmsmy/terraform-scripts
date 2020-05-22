variable "cluster_name" {
  description = "The name of the cluster resources" 
  type = string 

}

variable "server_port" {
  description = "The port for the httpd web server" 
  type = number 
  #default = 8080
}

variable "instance_type" {
  description = "The type of EC2 Instances to run (e.g. t2.micro)"
  type        = string
}
variable "min_size" {
  description = "The minimum number of EC2 Instances in the ASG"
  type        = number
}
variable "max_size" {
  description = "The maximum number of EC2 Instances in the ASG"
  type        = number
}