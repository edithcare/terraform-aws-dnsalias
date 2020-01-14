# Terraform DNS Alias

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

## Inputs

Please see the [variables.tf](variables.tf) file

## Outputs

Please see the [outputs.tf](outputs.tf) file
