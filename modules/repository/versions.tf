terraform {
  required_version = ">= 1.12"

  required_providers {
    github = {
      source  = "integrations/github"
      version = ">= 6.12"
    }
    telemetry = {
      source  = "tedilabs/telemetry"
      version = ">= 0.2.0"
    }
  }
}
