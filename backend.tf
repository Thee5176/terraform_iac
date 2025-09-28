terraform {
  cloud {

    organization = "thee5176"

    workspaces {
      name = "Accounting_CQRS_Dev"
    }
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.9.0"
    }
    github = {
      source  = "integrations/github"
      version = "~> 6.6.0"
    }
    null = {
      source  = "hashicorp/null"
      version = ">= 3.0.0"
    }
  }

  required_version = ">= 1.13.0"
}