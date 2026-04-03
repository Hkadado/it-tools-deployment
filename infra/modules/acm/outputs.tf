output "certificate_arn" {
  description = "ARN of the certificate"
  value       = aws_acm_certificate_validation.app.certificate_arn
}

output "certificate_domain_name" {
  description = "Domain name of the certificate"
  value       = aws_acm_certificate.app.domain_name
}

output "route53_zone_id" {
  description = "Route53 zone ID"
  value       = data.aws_route53_zone.main.zone_id
}
