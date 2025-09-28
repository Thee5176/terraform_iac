# ALB Security Group
resource "aws_security_group" "alb_sg" {
    description = "Allow HTTP inbound traffic"
    vpc_id      = var.vpc_id
    
    ingress {
        description = "HTTPS from anywhere"
        from_port   = 443
        to_port     = 443
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        Name    = "${var.project_name}_alb_sg"
        Environment = var.environment_name
    }
}

# ALB
resource "aws_lb" "backend_alb"{
    # name = "${var.project_name}-backend-alb"
    internal = false
    load_balancer_type = "application"
    security_groups = [aws_security_group.alb_sg.id]
    subnets = var.alb_subnet_ids # Internet-facing subnets

    enable_deletion_protection = true
    tags = {
        Name = "${var.project_name}_backend_alb"
        Environment = var.environment_name
    }
}


# ALB Listener
resource "aws_lb_listener" "alb_listener" {
    load_balancer_arn = aws_lb.backend_alb.arn
    port              = "80"
    protocol          = "HTTP"

    default_action {
        type             = "forward"
        target_group_arn = aws_lb_target_group.backend_target_group.arn
    }

    tags = {
                Name = "${var.project_name}_alb_listener"
                Environment = var.environment_name
        }
}

# Define Backend Target Group
resource "aws_lb_target_group" "backend_target_group" {
  # name        = "${var.project_name}-lb-tg"
  target_type = "instance"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = var.vpc_id

  tags = {
        Name = "${var.project_name}_backend_target_group"
        Environment = var.environment_name
    }
}

# Register Baclemd Target
resource "aws_lb_target_group_attachment" "app_instance" {
  target_group_arn = aws_lb_target_group.backend_target_group.arn
  target_id        = var.ec2_instance_id
  port             = 80
}

// TLS/ACM/Route53 removed per user request to prioritize getting infra up quickly.
// If you want HTTPS later, re-add ACM + Route53 code or supply hosted_zone_id.
