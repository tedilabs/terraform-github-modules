terraform {
  required_version = ">= 1.16"

  required_providers {
    github = {
      source  = "integrations/github"
      version = ">= 6.11"
    }
  }
}
