variable "project_name" {
    description = "catagorize the project provision"
    type        = string
}

variable "environment_name" {
    description = "catagorize environment purpose e.g.develop, production"
    type        = string
}

variable "db_username" {
  description = "RDS root username for the database"
  type        = string
}

variable "db_password" {
  description = "RDS root password for the database."
  type        = string
}

variable "db_schema" {
  description = "RDS database name to be created."
  type        = string
}

variable "vpc_id" {
  description = "VPC id where RDS resources will be created"
  type        = string
}

variable "db_subnet_ids" {
  description = "List of subnet ids for DB subnet group"
  type        = list(string)
}

variable "web_sg_id" {
  description = "Security group id of web (EC2) resources allowed to access DB"
  type        = string
}