variable "aws_region" {
  description = "AWS region to deploy into"
  type        = string
}

variable "project_name" {
  description = "Project name used for tagging/naming"
  type        = string
}

variable "container_image" {
  description = "Full ECR image URI"
  type        = string
}

variable "container_port" {
  description = "Port the container listens on"
  type        = number
  default     = 8080
}

variable "domain_name" {
  description = "Root domain name in Route53, e.g. example.com"
  type        = string
}

variable "subdomain" {
  description = "Subdomain for app, e.g. tm"
  type        = string
}