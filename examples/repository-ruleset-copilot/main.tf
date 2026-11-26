provider "github" {
  owner = var.owner
}

module "copilot_review" {
  source   = "../../modules/repository-ruleset"
  for_each = var.repositories

  repository = each.value
  name       = "copilot-code-review"
  target     = "branch"
  status     = "ACTIVE"

  conditions = {
    ref_name = {
      include = ["~DEFAULT_BRANCH"]
      exclude = []
    }
  }

  rules = {
    copilot_code_review = {
      review_on_push             = true
      review_draft_pull_requests = false
    }
  }
}
