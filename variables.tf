variable "project_name" {
  description = "Project name used for tagging"
  type        = string
  default     = "accounting-cqrs-project"
}

variable "environment_name" {
  description = "Environment name used for tagging"
  type        = string
}

variable "aws_access_key" {
  description = "AWS access key"
  type        = string
  sensitive   = true
}

variable "aws_secret_key" {
  description = "AWS secret key"
  type        = string
  sensitive   = true
}
variable "db_username" {
  description = "RDS root username for the database"
  type        = string
  default     = "db_master"
}

variable "db_password" {
  description = "RDS root password for the database."
  type        = string
  sensitive   = true
}

variable "db_schema" {
  description = "RDS database name to be created."
  type        = string
  default     = "record"
}

variable "jwt_secret" {
  description = "Secret key for signing JWT tokens"
  type        = string
  sensitive   = true
}
variable "github_owner" {
  description = "GitHub repository owner"
  type        = string
  default     = "Thee5176"
}
variable "github_token" {
  description = "GitHub token with repo and admin:repo_hook permissions"
  type        = string
  sensitive   = true
}

variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "ap-northeast-1"
}

variable "dockerhub_username" {
  description = "Docker Hub username"
  type        = string
  default     = "thee5176"
}

variable "dockerhub_token" {
  description = "Docker Hub access token"
  type        = string
  sensitive   = true
}

variable "ec2_private_key" {
  description = "Private key for SSH access to EC2 instance"
  type        = string
  sensitive   = true
}

variable "working_directory" {
  description = "Working directory for the project"
  type        = string
}

variable "command_service_port" {
  description = "Port for the Command Service"
  type        = number
  default     = 8181
}
variable "query_service_port" {
  description = "Port for the Query Service"
  type        = number
  default     = 8182
}
