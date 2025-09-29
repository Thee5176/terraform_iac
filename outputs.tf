output "ec2_instance_public_ip" {
  description = "EC2 public IP address (from ec2 module)"
  value       = module.ec2.ec2_public_ip
}

output "rds_endpoint" {
  description = "RDS access endpoint (from rds module)"
  value       = module.rds.db_endpoint
}

output "alb_dns_name" {
  description = "ALB DNS name (from alb module)"
  value       = module.alb.alb_dns_name
}