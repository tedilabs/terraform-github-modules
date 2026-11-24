provider "github" {
  owner = var.owner
}

module "copilot_review" {
  source = "../../modules/org-ruleset"
  name   = "copilot-code-review"
  target = "branch"
  status = "ACTIVE"

  conditions = {
    ref_name = {
      include = ["~DEFAULT_BRANCH"]
      exclude = []
    }
    repository_name = {
      include = sort(tolist(var.repositories))
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
