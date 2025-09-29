output "certificate_arn" {
    description = "ARN of the created ACM certificate"
    value       = aws_acm_certificate.ssl_cert.arn
}