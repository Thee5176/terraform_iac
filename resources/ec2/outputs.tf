
output "ec2_public_ip" {
	description = "Public IP address of the web server"
	value       = aws_instance.web_server.public_ip
}

output "web_sg_id" {
	description = "Security Group id created for web server"
	value       = aws_security_group.web_sg.id
}

