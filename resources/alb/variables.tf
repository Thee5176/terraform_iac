variable "project_name" {
    description = "catagorize the project provision"
    type        = string
}

variable "environment_name" {
    description = "catagorize environment purpose e.g.develop, production"
    type        = string
}

variable "vpc_id" {
    description = "VPC id where ALB and related resources will be created"
    type        = string
}

variable "alb_subnet_ids" {
    description = "list of subnets where ALB will be created"
    type        = list(string)
}

variable "ec2_instance_id" {
    description = "Instance id of the web server"
    type        = string
}

variable "domain_name" {
    description = "Domain name for the application load balancer"
    type        = string
}