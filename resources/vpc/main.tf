##----------------------------VPC Level--------------------------
# VPC : define resource group
resource "aws_vpc" "main_vpc" {
  cidr_block           = "172.16.0.0/16"
  instance_tenancy     = "default"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name    = "${var.project_name}_vpc"
    Environment = var.environment_name
  }
}

# Internet Gateway : allow access in VPC level
resource "aws_internet_gateway" "main_igw" {
  vpc_id     = aws_vpc.main_vpc.id
  depends_on = [aws_vpc.main_vpc]
  tags = {
    Name    = "${var.project_name}_igw"
    Environment = var.environment_name
  }
}

# Route Table :
resource "aws_route_table" "public_route" {
  vpc_id = aws_vpc.main_vpc.id
  tags = {
    Name    = "${var.project_name}_public_route"
    Environment = var.environment_name
  }
}

# EC2 Subnet : define IP address range based on VPC
resource "aws_subnet" "web_subnet" {
  vpc_id            = aws_vpc.main_vpc.id
  cidr_block        = "172.16.0.0/24"
  availability_zone = "ap-northeast-1a"

  tags = {
    Name    = "${var.project_name}_web_subnet"
    Environment = var.environment_name
  }
}

# DB Subnet 1
resource "aws_subnet" "db_subnet_1" {
  vpc_id            = aws_vpc.main_vpc.id
  cidr_block        = "172.16.1.0/24"
  availability_zone = "ap-northeast-1a"

  tags = {
    Name    = "${var.project_name}_db_subnet_1"
    Environment = var.environment_name
  }
}

# DB Subnet 2
resource "aws_subnet" "db_subnet_2" {
  vpc_id            = aws_vpc.main_vpc.id
  cidr_block        = "172.16.2.0/24"
  availability_zone = "ap-northeast-1c"

  tags = {
    Name    = "${var.project_name}_db_subnet_2"
    Environment = var.environment_name
  }
}

# Public Table Association : connect EC2 subnet with public route table
resource "aws_route_table_association" "public_subnet_association" {
  subnet_id      = aws_subnet.web_subnet.id
  route_table_id = aws_route_table.public_route.id
}


# RDS Table Association : connect RDS subnet with public route table
resource "aws_route_table_association" "db_subnet1_assoc" {
  subnet_id      = aws_subnet.db_subnet_1.id
  route_table_id = aws_route_table.public_route.id
}

resource "aws_route_table_association" "db_subnet2_assoc" {
  subnet_id      = aws_subnet.db_subnet_2.id
  route_table_id = aws_route_table.public_route.id
}

# Route : connect internet gateway with route table
resource "aws_route" "public_route" {
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.main_igw.id
  route_table_id         = aws_route_table.public_route.id
}