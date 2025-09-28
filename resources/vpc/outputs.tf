output "vpc_id" {
  value = aws_vpc.main_vpc.id
}

output "web_subnet_id" {
  value = aws_subnet.web_subnet.id
}

output "db_subnet_ids" {
  value = [aws_subnet.db_subnet_1.id, aws_subnet.db_subnet_2.id]
}