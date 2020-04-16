output record_name {
  value       = aws_route53_record.record.fqdn
  description = "The FQDN of the resulting DNS record."
}

output bucket_arn {
  value       = aws_s3_bucket.bucket_index[0].arn
  description = "The arn of the s3-bucket."
}