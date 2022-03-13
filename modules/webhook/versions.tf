terraform {
  required_version = ">= 1.1"

  required_providers {
    github = {
      # source  = "integrations/github"
      # version = ">= 4.19"
      source  = "hashicorp/github"
      version = "= 4.13.0"
    }
  }
}
