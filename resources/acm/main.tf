# SSL Certificates - Using manually imported ACM certificate by domain
data "aws_acm_certificate" "my_ssl_cert" {
  domain      = var.domain_name
  types       = ["IMPORTED"]
  statuses    = ["ISSUED"]
  most_recent = true
}

# Route53 Hosted Zone
resource "aws_route53_zone" "main" {
  name = var.domain_name

  tags = {
    Name        = "${var.project_name}-${var.environment_name}-hosted-zone"
    Project     = var.project_name
    Environment = var.environment_name
  }
}