variable "name" {
  description = "(Required) The name of the organization ruleset."
  type        = string
  nullable    = false
}

variable "target" {
  description = "(Optional) The target of the ruleset. Can be one of `branch`, `tag`, or `push`. Defaults to `branch`."
  type        = string
  default     = "branch"
  nullable    = false

  validation {
    condition     = contains(["branch", "tag", "push"], var.target)
    error_message = "Valid values for `target` are `branch`, `tag`, or `push`."
  }
}

variable "status" {
  description = "(Optional) The status (enforcement level) of the ruleset. Can be one of `ACTIVE`, `EVALUATE`, or `DISABLED`. Use `EVALUATE` to monitor (dry-run) which actions would be blocked without actually blocking them. Defaults to `ACTIVE`."
  type        = string
  default     = "ACTIVE"
  nullable    = false

  validation {
    condition     = contains(["ACTIVE", "EVALUATE", "DISABLED"], var.status)
    error_message = "Valid values for `status` are `ACTIVE`, `EVALUATE`, or `DISABLED`."
  }
}

variable "bypass_list" {
  description = <<EOF
  (Optional) A list of actors that are allowed to bypass the rules of the ruleset. Each item of `bypass_list` block as defined below.
    (Required) `actor` - A configuration for the actor that can bypass the ruleset. `actor` block as defined below.
      (Required) `type` - The type of actor that can bypass the ruleset. Can be one of `RepositoryRole`, `Team`, `Integration`, `OrganizationAdmin`, or `DeployKey`.
      (Optional) `id` - The ID of the actor that can bypass the ruleset. When `type` is `OrganizationAdmin`, this should be `1`. For repository roles, use `1` (maintain), `2` (write), `3` (admin), `4` (read), or `5` (triage).
    (Optional) `mode` - The mode by which the actor can bypass the ruleset. Can be one of `always` or `pull_request`. Defaults to `always`.
  EOF
  type = list(object({
    actor = object({
      type = string
      id   = optional(number)
    })
    mode = optional(string, "always")
  }))
  default  = []
  nullable = false

  validation {
    condition = alltrue([
      for item in var.bypass_list :
      contains(["RepositoryRole", "Team", "Integration", "OrganizationAdmin", "DeployKey"], item.actor.type)
    ])
    error_message = "Valid values for `bypass_list.*.actor.type` are `RepositoryRole`, `Team`, `Integration`, `OrganizationAdmin`, or `DeployKey`."
  }

  validation {
    condition = alltrue([
      for item in var.bypass_list :
      contains(["always", "pull_request"], item.mode)
    ])
    error_message = "Valid values for `bypass_list.*.mode` are `always` or `pull_request`."
  }
}

variable "conditions" {
  description = <<EOF
  (Optional) A configuration for the conditions that determine which repositories and refs the ruleset applies to. `conditions` block as defined below.
    (Optional) `ref_name` - A configuration for matching refs (branches or tags). Required when `target` is `branch` or `tag`. `ref_name` block as defined below.
      (Optional) `include` - A list of ref names or patterns to include. One of these patterns must match for the condition to pass. Also accepts the special values `~ALL` (all refs) and `~DEFAULT_BRANCH` (the default branch).
      (Optional) `exclude` - A list of ref names or patterns to exclude. The condition will not pass if any of these patterns match.
    (Optional) `repository_name` - A configuration for matching repositories by name. Conflicts with `repository_ids`. `repository_name` block as defined below.
      (Optional) `include` - A list of repository names or patterns to include. Also accepts the special value `~ALL`.
      (Optional) `exclude` - A list of repository names or patterns to exclude.
      (Optional) `protected` - Whether to only include repositories with the default branch protected. Defaults to `false`.
    (Optional) `repository_ids` - A list of repository IDs to target. Conflicts with `repository_name`.
  EOF
  type = object({
    ref_name = optional(object({
      include = optional(list(string), [])
      exclude = optional(list(string), [])
    }), {})
    repository_name = optional(object({
      include   = optional(list(string), [])
      exclude   = optional(list(string), [])
      protected = optional(bool, false)
    }))
    repository_ids = optional(list(number))
  })
  default  = {}
  nullable = false

  validation {
    condition     = !(var.conditions.repository_name != null && var.conditions.repository_ids != null)
    error_message = "Only one of `conditions.repository_name` or `conditions.repository_ids` can be set."
  }
}

variable "rules" {
  description = <<EOF
  (Optional) A configuration for the rules enforced by the ruleset. `rules` block as defined below.
    (Optional) `creation` - Whether to restrict the creation of matching refs. Defaults to `false`.
    (Optional) `update` - Whether to restrict updates to matching refs. Defaults to `false`.
    (Optional) `deletion` - Whether to restrict deletion of matching refs. Defaults to `false`.
    (Optional) `required_linear_history` - Whether to require a linear commit history, preventing merge commits. Defaults to `false`.
    (Optional) `required_signatures` - Whether to require commits pushed to matching refs to have verified signatures. Defaults to `false`.
    (Optional) `non_fast_forward` - Whether to block force pushes to matching refs. Defaults to `false`.
    (Optional) `pull_request` - A configuration to require a pull request before merging. `pull_request` block as defined below.
      (Optional) `dismiss_stale_reviews_on_push` - Whether to dismiss approving reviews when new commits are pushed. Defaults to `false`.
      (Optional) `require_code_owner_review` - Whether to require review from code owners. Defaults to `false`.
      (Optional) `require_last_push_approval` - Whether the most recent push must be approved by someone other than its author. Defaults to `false`.
      (Optional) `required_approving_review_count` - The number of approving reviews required before merging. Defaults to `0`.
      (Optional) `required_review_thread_resolution` - Whether all review conversations must be resolved before merging. Defaults to `false`.
    (Optional) `required_status_checks` - A configuration to require status checks to pass before merging. `required_status_checks` block as defined below.
      (Optional) `checks` - A list of status checks that must pass. Each item of `checks` block as defined below.
        (Required) `context` - The name of the required status check.
        (Optional) `integration_id` - The ID of the GitHub App that provides the status check. Use `0` for checks not provided by an app.
      (Optional) `strict_required_status_checks_policy` - Whether the matching ref must be up to date with the base branch before merging. Defaults to `false`.
    (Optional) `required_workflows` - A configuration to require GitHub Actions workflows to pass before merging. `required_workflows` block as defined below.
      (Required) `workflows` - A list of workflows that must pass. Each item of `workflows` block as defined below.
        (Required) `repository_id` - The ID of the repository where the workflow is defined.
        (Required) `path` - The path to the workflow file (e.g., `.github/workflows/scan.yaml`).
        (Optional) `ref` - The ref of the workflow file. Defaults to the repository's default branch.
      (Optional) `do_not_enforce_on_create` - Whether to skip enforcing the workflows when a matching ref is created. Defaults to `false`.
    (Optional) `required_code_scanning` - A configuration to require code scanning results before merging. `required_code_scanning` block as defined below.
      (Required) `tools` - A list of code scanning tools that must run. Each item of `tools` block as defined below.
        (Required) `tool` - The name of the code scanning tool (e.g., `CodeQL`).
        (Required) `alerts_threshold` - The severity level at which code scanning alerts block merging. Can be one of `none`, `errors`, `errors_and_warnings`, or `all`.
        (Required) `security_alerts_threshold` - The severity level at which code scanning security alerts block merging. Can be one of `none`, `critical`, `high_or_higher`, `medium_or_higher`, or `all`.
    (Optional) `branch_name_pattern` - A configuration to enforce a naming pattern on branches. Only valid when `target` is `branch`. `pattern` block as defined below.
    (Optional) `tag_name_pattern` - A configuration to enforce a naming pattern on tags. Only valid when `target` is `tag`. `pattern` block as defined below.
    (Optional) `commit_message_pattern` - A configuration to enforce a pattern on commit messages. `pattern` block as defined below.
    (Optional) `commit_author_email_pattern` - A configuration to enforce a pattern on commit author emails. `pattern` block as defined below.
    (Optional) `committer_email_pattern` - A configuration to enforce a pattern on committer emails. `pattern` block as defined below.
      (Required) `operator` - How the pattern is matched. Can be one of `starts_with`, `ends_with`, `contains`, or `regex`.
      (Required) `pattern` - The pattern to match against.
      (Optional) `name` - A display name for the rule.
      (Optional) `negate` - Whether to negate the match (i.e., fail if the pattern matches). Defaults to `false`.
  EOF
  type = object({
    creation                = optional(bool, false)
    update                  = optional(bool, false)
    deletion                = optional(bool, false)
    required_linear_history = optional(bool, false)
    required_signatures     = optional(bool, false)
    non_fast_forward        = optional(bool, false)

    pull_request = optional(object({
      dismiss_stale_reviews_on_push     = optional(bool, false)
      require_code_owner_review         = optional(bool, false)
      require_last_push_approval        = optional(bool, false)
      required_approving_review_count   = optional(number, 0)
      required_review_thread_resolution = optional(bool, false)
    }))

    required_status_checks = optional(object({
      checks = optional(list(object({
        context        = string
        integration_id = optional(number, 0)
      })), [])
      strict_required_status_checks_policy = optional(bool, false)
    }))

    required_workflows = optional(object({
      workflows = list(object({
        repository_id = number
        path          = string
        ref           = optional(string)
      }))
      do_not_enforce_on_create = optional(bool, false)
    }))

    required_code_scanning = optional(object({
      tools = list(object({
        tool                      = string
        alerts_threshold          = string
        security_alerts_threshold = string
      }))
    }))

    branch_name_pattern = optional(object({
      operator = string
      pattern  = string
      name     = optional(string)
      negate   = optional(bool, false)
    }))
    tag_name_pattern = optional(object({
      operator = string
      pattern  = string
      name     = optional(string)
      negate   = optional(bool, false)
    }))
    commit_message_pattern = optional(object({
      operator = string
      pattern  = string
      name     = optional(string)
      negate   = optional(bool, false)
    }))
    commit_author_email_pattern = optional(object({
      operator = string
      pattern  = string
      name     = optional(string)
      negate   = optional(bool, false)
    }))
    committer_email_pattern = optional(object({
      operator = string
      pattern  = string
      name     = optional(string)
      negate   = optional(bool, false)
    }))
  })
  default  = {}
  nullable = false

  validation {
    condition = alltrue([
      for pattern in [
        var.rules.branch_name_pattern,
        var.rules.tag_name_pattern,
        var.rules.commit_message_pattern,
        var.rules.commit_author_email_pattern,
        var.rules.committer_email_pattern,
      ] :
      contains(["starts_with", "ends_with", "contains", "regex"], pattern.operator)
      if pattern != null
    ])
    error_message = "Valid values for the `operator` of any `*_pattern` rule are `starts_with`, `ends_with`, `contains`, or `regex`."
  }
}
