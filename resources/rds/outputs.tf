
output "db_endpoint" {
	description = "Endpoint address of the RDS instance"
	value       = aws_db_instance.web_db.endpoint
}
