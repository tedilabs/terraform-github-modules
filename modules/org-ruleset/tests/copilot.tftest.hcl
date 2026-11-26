mock_provider "github" {}

variables {
  name = "copilot-code-review"
  conditions = {
    ref_name        = { include = ["~DEFAULT_BRANCH"] }
    repository_name = { include = ["example"] }
  }
  telemetry = { enabled = false }
}

run "omitted" {
  command = plan

  variables {
    rules = {}
  }

  assert {
    condition     = length(github_organization_ruleset.this.rules[0].copilot_code_review) == 0
    error_message = "Omitting Copilot must not create an automatic review rule."
  }
}

run "explicit_null" {
  command = plan

  variables {
    rules = { copilot_code_review = null }
  }

  assert {
    condition     = length(github_organization_ruleset.this.rules[0].copilot_code_review) == 0
    error_message = "Omitting Copilot must not create an automatic review rule."
  }
}

run "defaults" {
  command = plan

  variables {
    rules = { copilot_code_review = {} }
  }

  assert {
    condition     = length(github_organization_ruleset.this.rules[0].copilot_code_review) == 1 && github_organization_ruleset.this.rules[0].copilot_code_review[0].review_on_push == false && github_organization_ruleset.this.rules[0].copilot_code_review[0].review_draft_pull_requests == false
    error_message = "Copilot must be enabled with the requested push and draft options."
  }

  assert {
    condition     = length(github_organization_ruleset.this.rules[0].pull_request) == 0
    error_message = "Automatic reviews must not introduce pull request merge requirements."
  }
}

run "new_pushes" {
  command = plan

  variables {
    rules = { copilot_code_review = { review_on_push = true } }
  }

  assert {
    condition     = length(github_organization_ruleset.this.rules[0].copilot_code_review) == 1 && github_organization_ruleset.this.rules[0].copilot_code_review[0].review_on_push == true && github_organization_ruleset.this.rules[0].copilot_code_review[0].review_draft_pull_requests == false
    error_message = "Copilot must be enabled with the requested push and draft options."
  }

  assert {
    condition     = length(github_organization_ruleset.this.rules[0].pull_request) == 0
    error_message = "Automatic reviews must not introduce pull request merge requirements."
  }
}

run "drafts" {
  command = plan

  variables {
    rules = { copilot_code_review = { review_draft_pull_requests = true } }
  }

  assert {
    condition     = length(github_organization_ruleset.this.rules[0].copilot_code_review) == 1 && github_organization_ruleset.this.rules[0].copilot_code_review[0].review_on_push == false && github_organization_ruleset.this.rules[0].copilot_code_review[0].review_draft_pull_requests == true
    error_message = "Copilot must be enabled with the requested push and draft options."
  }

  assert {
    condition     = length(github_organization_ruleset.this.rules[0].pull_request) == 0
    error_message = "Automatic reviews must not introduce pull request merge requirements."
  }
}

run "both_options" {
  command = plan

  variables {
    rules = { copilot_code_review = { review_on_push = true, review_draft_pull_requests = true } }
  }

  assert {
    condition     = length(github_organization_ruleset.this.rules[0].copilot_code_review) == 1 && github_organization_ruleset.this.rules[0].copilot_code_review[0].review_on_push == true && github_organization_ruleset.this.rules[0].copilot_code_review[0].review_draft_pull_requests == true
    error_message = "Copilot must be enabled with the requested push and draft options."
  }

  assert {
    condition     = length(github_organization_ruleset.this.rules[0].pull_request) == 0
    error_message = "Automatic reviews must not introduce pull request merge requirements."
  }
}

run "reject_tag" {
  command = plan

  variables {
    target = "tag"
    rules  = { copilot_code_review = {} }
  }

  expect_failures = [var.rules]
}

run "reject_push" {
  command = plan

  variables {
    target = "push"
    rules  = { copilot_code_review = {} }
  }

  expect_failures = [var.rules]
}

run "disabled" {
  command = plan

  variables {
    status = "DISABLED"
    rules  = { copilot_code_review = {} }
  }

  assert {
    condition     = github_organization_ruleset.this.enforcement == "disabled" && output.status == "DISABLED"
    error_message = "The module must translate status to the provider enforcement value."
  }
}

run "existing_rules" {
  command = plan

  variables {
    rules = {
      non_fast_forward = true
      pull_request     = { required_approving_review_count = 1 }
    }
  }

  assert {
    condition     = github_organization_ruleset.this.rules[0].non_fast_forward && github_organization_ruleset.this.rules[0].pull_request[0].required_approving_review_count == 1 && length(github_organization_ruleset.this.rules[0].copilot_code_review) == 0
    error_message = "Existing rules must remain unchanged without opting into Copilot."
  }
}
