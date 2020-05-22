provider "aws" {
  version = "~> 2.59"
  region = "us-east-2"
  shared_credentials_file = "C:\\Users\\me\\.aws"
  profile                 = "myawscloud"
}

module "webserver_cluster" {
  source = "../../../modules/services/webserver-cluster"
  server_port = "8080"
  cluster_name = "webservers-stage"
  instance_type = "t2.micro"
  min_size      = 1
  max_size      = 2
}


output "clb_dns_name" {
  value       = module.webserver_cluster.clb_dns_name
  description = "The domain name of the load balancer"
}