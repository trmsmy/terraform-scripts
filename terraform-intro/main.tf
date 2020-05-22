provider "aws" {
  version = "~> 2.59"
  region = "us-east-2"
  shared_credentials_file = "C:\\Users\\me\\.aws"
  profile                 = "myawscloud"
}

variable "server_port" {
  description = "The port for the httpd web server" 
  type = number 
  default = 8080
}

variable "noof_servers_min" {
  description = "Minimum number of servers in autoscaling group" 
  type = number 
  default = 1
}

variable "noof_servers_max" {
  description = "Maximum number of servers in autoscaling group" 
  type = number 
  default = 2
}


resource "aws_launch_configuration" "example" {
  image_id        = "ami-0c55b159cbfafe1f0"
  instance_type   = "t2.micro"
  security_groups = [aws_security_group.example.id]

  user_data = <<-EOF
              #!/bin/bash
              random_str=$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 13)
              echo "Hello, World from $random_str" > index.html
              nohup busybox httpd -f -p "${var.server_port}" &
              EOF

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "example" {
  launch_configuration = aws_launch_configuration.example.id
  availability_zones = data.aws_availability_zones.all.names

  min_size = var.noof_servers_min
  max_size = var.noof_servers_max

  load_balancers    = [aws_elb.example.name]
  health_check_type = "ELB"

  tag {
    key                 = "Name"
    value               = "terraform-ec2-example"
    propagate_at_launch = true
  }
}

data "aws_availability_zones" "all" {}

resource "aws_elb" "example" {
  name               = "terraform-asg-example"
  security_groups    = [aws_security_group.elb.id] 
  availability_zones = data.aws_availability_zones.all.names

  health_check {
    target              = "HTTP:${var.server_port}/"
    interval            = 30
    timeout             = 3
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }

  # This adds a listener for incoming HTTP requests.
  listener {
    lb_port           = 80
    lb_protocol       = "http"
    instance_port     = var.server_port
    instance_protocol = "http"
  }
}

resource "aws_security_group" "example" {

  name = "terraform-example"

  ingress {
    from_port   = var.server_port
    to_port     = var.server_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


}

resource "aws_security_group" "elb" {

  name = "terraform-example-elb"


  # Inbound HTTP from anywhere
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

    # Allow HTTP:80 outbound
  egress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
output "clb_dns_name" {
  value       = aws_elb.example.dns_name
  description = "The domain name of the load balancer"
}