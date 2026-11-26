locals {
  metadata = {
    package = "terraform-github-modules"
    version = trimspace(file("${path.module}/../../VERSION"))
    module  = basename(path.module)
    name    = "${var.repository}/${var.name}"
  }
}


###################################################
# Repository Ruleset
###################################################

resource "github_repository_ruleset" "this" {
  repository  = var.repository
  name        = var.name
  target      = var.target
  enforcement = lower(var.status)

  conditions {
    ref_name {
      include = var.conditions.ref_name.include
      exclude = var.conditions.ref_name.exclude
    }
  }

  rules {
    dynamic "copilot_code_review" {
      for_each = var.rules.copilot_code_review != null ? [var.rules.copilot_code_review] : []

      content {
        review_on_push             = copilot_code_review.value.review_on_push
        review_draft_pull_requests = copilot_code_review.value.review_draft_pull_requests
      }
    }
  }
}
