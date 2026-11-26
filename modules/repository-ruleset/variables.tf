variable "repository" {
  description = "(Required) The repository name which the ruleset belongs to. The owner is configured through the GitHub provider."
  type        = string
  nullable    = false
}

variable "name" {
  description = "(Required) The name of the repository ruleset."
  type        = string
  nullable    = false
}

variable "target" {
  description = "(Optional) The target of the ruleset. Currently only `branch` is supported. Defaults to `branch`."
  type        = string
  default     = "branch"
  nullable    = false

  validation {
    condition     = var.target == "branch"
    error_message = "Only `branch` is supported for `target`."
  }
}

variable "status" {
  description = "(Optional) The status (enforcement level) of the ruleset. Can be one of `ACTIVE` or `DISABLED`. Defaults to `ACTIVE`."
  type        = string
  default     = "ACTIVE"
  nullable    = false

  validation {
    condition     = contains(["ACTIVE", "DISABLED"], var.status)
    error_message = "Valid values for `status` are `ACTIVE` or `DISABLED`."
  }
}

variable "conditions" {
  description = <<EOF
  (Optional) A configuration for the conditions that determine which refs the ruleset applies to. `conditions` block as defined below.
    (Optional) `ref_name` - A configuration for matching branches. `ref_name` block as defined below.
      (Optional) `include` - A list of ref names or patterns to include. Also accepts `~ALL` and `~DEFAULT_BRANCH`. Defaults to `["~DEFAULT_BRANCH"]`.
      (Optional) `exclude` - A list of ref names or patterns to exclude. Defaults to `[]`.
  EOF
  type = object({
    ref_name = optional(object({
      include = optional(list(string), ["~DEFAULT_BRANCH"])
      exclude = optional(list(string), [])
    }), {})
  })
  default  = {}
  nullable = false
}

variable "rules" {
  description = <<EOF
  (Optional) A configuration for the rules enforced by the ruleset. Currently only Copilot code review is supported. `rules` block as defined below.
    (Optional) `copilot_code_review` - A configuration to automatically request Copilot code reviews. Only valid when `target` is `branch`. Omit or set to `null` to omit this rule; set to `{}` to enable reviews with the default options. `copilot_code_review` block as defined below.
      (Optional) `review_on_push` - Whether to review each new push to a pull request. Defaults to `false`.
      (Optional) `review_draft_pull_requests` - Whether to review draft pull requests before they are ready for review. Defaults to `false`.
  EOF
  type = object({
    copilot_code_review = optional(object({
      review_on_push             = optional(bool, false)
      review_draft_pull_requests = optional(bool, false)
    }))
  })
  default  = {}
  nullable = false
}
