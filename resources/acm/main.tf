# # SSL Certificate
# resource "aws_acm_certificate" "ssl_cert" {
#   domain_name       = var.domain_name
#   validation_method = "DNS"

#   tags = {
#       Name = "${var.project_name}_ssl_cert"
#       Environment = var.environment_name
#   }

#   lifecycle {
#     create_before_destroy = true
#   }
# }

# resource "aws_route53_zone" "main" {
#   name         = var.domain_name
# }

# locals {
#   cert_dvos = { for dvo in aws_acm_certificate.ssl_cert.domain_validation_options : dvo.domain_name => dvo }
# }

# # Create DNS validation records returned by ACM
# resource "aws_route53_record" "cert_validation" {
#   for_each = local.cert_dvos

#   zone_id = aws_route53_zone.main.zone_id
#   name    = each.value.resource_record_name
#   type    = each.value.resource_record_type
#   ttl     = 60
#   records = [each.value.resource_record_value]
# }

# # Validate the ACM certificate using the created Route53 records
# resource "aws_acm_certificate_validation" "ssl_cert_validation" {
#   certificate_arn         = aws_acm_certificate.ssl_cert.arn
#   validation_record_fqdns = [for r in aws_route53_record.cert_validation : r.fqdn]

#   # Ensure certificate is created before validation resource is destroyed/created
#   lifecycle {
#     create_before_destroy = true
#   }
# }

# # Ensure the ALB listener waits for the certificate validation to complete
# resource "null_resource" "wait_for_cert_validation" {
#   depends_on = [aws_acm_certificate_validation.ssl_cert_validation]
# }