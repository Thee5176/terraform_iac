##------------------------EC2 Instance---------------------------
# EC2
resource "aws_instance" "web_server" {
  ami                         = "ami-000322c84e9ff1be2" #Amazon Linux 2 (ap-ne-1)
  instance_type               = "t3.micro"
  key_name                    = data.aws_key_pair.deployment_key.key_name
  subnet_id                   = var.web_subnet_id
  vpc_security_group_ids      = [aws_security_group.web_sg.id]
  associate_public_ip_address = true

  user_data = <<EOF
    #!/bin/bash
    
    # Update the system
    sudo yum update -y

    # Install Git
    sudo yum install -y git

    # Install Docker and Docker Compose
    sudo yum install -y docker
    sudo service docker start
    sudo usermod -a -G docker ec2-user
    docker --version

    sudo curl -L https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose
    sudo chmod +x /usr/local/bin/docker-compose
    docker-compose --version

    # Clone the repository and checkout the docker directory
    git clone --recurse-submodules -j3 https://github.com/Thee5176/SpringBoot_CQRS
    cd SpringBoot_CQRS
    git sparse-checkout set docker react_mui_cqrs --no-cone
  EOF

  tags = {
    Name    = "${var.project_name}_ec2_instance"
    Environment = var.environment_name
  }
}

# EC2 Security Group : allow access in instance level
resource "aws_security_group" "web_sg" {
  description = "Allow SSH and HTTP inbound traffic"
  vpc_id      = var.vpc_id
  ingress {
    description = "SSH from anywhere"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP from anywhere"
    from_port   = 80
    to_port     = 80 # Frontend Port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow incoming data fetch to command service"
    from_port   = var.command_service_port
    to_port     = var.query_service_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name    = "${var.project_name}_ec2_sg"
    Environment = var.environment_name
  }
}

# EC2 SSH Key
data "aws_key_pair" "deployment_key" { # Manually created on aws console
  key_name = "github_workflow_key"
  tags = {
    Name    = "${var.project_name}_ec2_deployment_key"
    Environment = var.environment_name
  }
}

# # EC2 Elastic IP : Set static IP address
# resource "aws_eip" "web_eip" {
#   instance = aws_instance.web_server.id
#   domain   = "vpc"
#   tags = {
#     Name = "${var.project_name}_ec2_eip"
#     Environment = var.environment_name  
#   }
# }
