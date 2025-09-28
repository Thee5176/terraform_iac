output "vpc_id" {
  value = aws_vpc.main_vpc.id
}

output "web_subnet_id" {
  value = aws_subnet.web_subnet.id
}

output "db_subnet_ids" {
  value = aws_subnet.db_subnet[*].id
}

output "alb_subnet_ids" {
  value = aws_subnet.alb_subnet[*].id
}