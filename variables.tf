variable "alias_name" {
  type        = string
  description = "The name of the alias."
}

variable "alternative_aliases" {
  type        = list(string)
  default     = []
  description = "The name of the alterantive aliases."
}

variable "zone_name" {
  type        = string
  description = "The name of the DNS zone"
}

variable "aws_zone_id" {
  type        = string
  description = "The AWS zone id."
}

variable "aws_account_id" {
  type        = string
  description = "The AWS account id."
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

variable "create_index" {
  type        = bool
  default     = true
  description = "the index.html file is created when this variable is true. Also the index.html file will be overwritten each run, if this variable is true"
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

variable "cloudfront_max_ttl" {
  type        = number
  default     = 31536000
  description = "The maximum ttl of an Object delivered via Cloudfront"
}

variable "cloudfront_default_ttl" {
  type        = number
  default     = 86400
  description = "The default ttl of an Object delivered via Cloudfront"
}
