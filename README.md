# Terraform DNS Alias

![Terraform GitHub Actions](https://github.com/edithcare/terraform-aws-dnsalias/workflows/Terraform%20GitHub%20Actions/badge.svg)

This terraform module represents a DNS alias that can be used for automatic redirection. Without an explicit redirection url,
the target bucket will be configured for web hosting, containing an index.html with automatic redirection via JS 
to the project homepage.

## Requirements

* [Terraform](https://www.terraform.io/downloads.html)
* Atom has great support for Terraform, please see
    * [language-terraform](https://atom.io/packages/language-terraform)
    * [linter-terraform-syntax](https://atom.io/packages/linter-terraform-syntax)
* [Free Terraform Enterprise Account](https://app.terraform.io/account/new) for accessing and locking the cluster environment state
* Let the Terraform Enterprise [admin](https://github.com/drobakowski) add you to the organisation `edithcare`

## TODO

The [src/index.html](src/index.html) contains the absolute URL of the project. This should be replaced by a template.


## Inputs

Please see the [variables.tf](variables.tf) file

## Outputs

Please see the [output.tf](output.tf) file
