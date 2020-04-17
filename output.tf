output record_name {
  value       = aws_route53_record.record.fqdn
  description = "The FQDN of the resulting DNS record."
}
