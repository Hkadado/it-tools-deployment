variable "name" {
  description = "Name prefix for ACM resources"
  type        = string
}

variable "domain_name" {
  description = "The domain name for the certificate"
  type        = string
}

variable "subdomain" {
  description = "The subdomain for the certificate"
  type        = string
}

variable "alb_dns_name" {
  description = "DNS name of the ALB"
  type        = string
}

variable "alb_zone_id" {
  description = "Zone ID of the ALB"
  type        = string
}
