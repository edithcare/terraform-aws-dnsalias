variable "alias_name" {
  type        = string
  description = "The name of the alias."
}

variable "zone_name" {
  type        = string
  description = "The name of the DNS zone"
}

variable "aws_zone_id" {
  type        = string
  description = "The AWS zone id."
}

variable "aws_essential_account_id" {
  type        = string
  description = "The AWS account id of the essential account."
}

variable "aws_s3_bucket_hosted_zone_id" {
  type        = string
  description = "The zone id for the AWS hosted S3 bucket"
}

variable "aws_region" {
  type        = string
  default     = "eu-central-1"
  description = "The region for the AWS DNS zone."
}

variable "redirection_url" {
  type        = string
  default     = ""
  description = "The target URL for redirection. Leave empty for static website hosting configuration."
}

variable "enable_public_access" {
  type        = bool
  default     = false
  description = "Enables public access on S3 bucket. Only effective when using static website hosting."
}

variable "aws_cert_arn" {
  type        = string
  description = "AWS ARN for the certificate. Must be configured in us-east-1."
}

variable "viewer_protocol_policy" {
  type        = string
  default     = "redirect-to-https"
  description = "Viewer protocol policy of the AWS CloudFront distribution default cache behaviour."
}
