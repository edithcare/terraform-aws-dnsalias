# Terraform DNS Alias

![Terraform GitHub Actions](https://github.com/edithcare/terraform-aws-dnsalias/workflows/Terraform%20GitHub%20Actions/badge.svg)

This terraform module represents a DNS alias that can be used for automatic redirection. Without an explicit redirection url,
the target bucket will be configured for web hosting, containing an index.html with automatic redirection via JS to the project homepage.

## requirements
* [terraform](https://www.terraform.io/downloads.html)
* [Free Terraform Enterprise Account](https://app.terraform.io/account/new) for accessing and locking the cluster environment state
* Let the Terraform Enterprise [admin](https://github.com/drobakowski) add you to the organisation `edithcare`

## inputs and outputs

Please see the [variables.tf](variables.tf) and [output.tf](output.tf) respectively.

## TODO
- [EC-3217](https://edithcare.atlassian.net/browse/EC-3217) add tag `managed-by` 
- [EC-3216](https://edithcare.atlassian.net/browse/EC-3216) [src/index.html](src/index.html) contains the absolute URL of the project. This should be replaced by a template.
- [EC-2293](https://edithcare.atlassian.net/browse/EC-2293) [CRITICAL] S3.2 S3 buckets should prohibit public read access
  - [aws.amazon.com/premiumsupport/knowledge-center/cloudfront-access-to-amazon-s3/](https://aws.amazon.com/premiumsupport/knowledge-center/cloudfront-access-to-amazon-s3/)
  - [aws.amazon.com/premiumsupport/knowledge-center/cloudfront-serve-static-website/](https://aws.amazon.com/premiumsupport/knowledge-center/cloudfront-serve-static-website/)

```json
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "PublicReadGetObject",
            "Effect": "Allow",
            "Principal": "*",     
            "Action": "s3:GetObject",
            "Resource": "arn:aws:s3:::sectest.edith.care/*"
        }
    ]
}

{
    "Version": "2008-10-17",
    "Id": "PolicyForCloudFrontPrivateContent",
    "Statement": [
        {
            "Sid": "1",
            "Effect": "Allow",
            "Principal": {
                "AWS": "arn:aws:iam::cloudfront:user/CloudFront Origin Access Identity E2VEE0PSS7J353"
            },
            "Action": "s3:GetObject",
            "Resource": "arn:aws:s3:::sectest.edith.care/*"
        }
    ]
}
```
