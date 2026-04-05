variable "repository" {
  description = "(Required) The repository name which the environment belongs to."
  type        = string
  nullable    = false
}

variable "name" {
  description = "(Required) The name of the environment."
  type        = string
  nullable    = false
}

variable "wait_timer" {
  description = "(Optional) The amount of time in minutes to wait before allowing deployments to proceed. The default value is `0`."
  type        = number
  default     = 0
  nullable    = false
}

variable "allow_admin_to_bypass" {
  description = "(Optional) Whether to allow admins to bypass the wait timer and deployment review. The default value is `true`."
  type        = bool
  default     = true
  nullable    = false
}

variable "allow_self_approval" {
  description = "(Optional) Whether to allow users to approve their own deployment. The default value is `false`."
  type        = bool
  default     = false
  nullable    = false
}

variable "reviewers" {
  description = <<EOF
  (Optional) A list of reviewers who may review jobs that reference the environment. Up to 6 reviewers can be added to an environment. Each item of `reviewers` block as defined below.
    (Required) `type` - The type of the reviewer. Valid values are `USER` or `TEAM`.
    (Required) `name` - The username of the reviewer if the type is `USER`, or the team slug if the type is `TEAM`.
  EOF
  type = list(object({
    type = string
    name = string
  }))
  default  = []
  nullable = false

  validation {
    condition = alltrue([
      for reviewer in var.reviewers :
      contains(["USER", "TEAM"], reviewer.type)
    ])
    error_message = "Valid values for `type` are `USER` or `TEAM`."
  }
  validation {
    condition     = length(var.reviewers) <= 6
    error_message = "Up to 6 reviewers can be added to an environment."
  }
}

variable "deployment_policy" {
  description = <<EOF
  (Optional) A configuration for deployment policy. `deployment_policy` block as defined below.
    (Optional) `restriction` - The type of deployment restriction. Valid values are `NONE`, `PROTECTED_BRANCH`, or `CUSTOM`. Defaults to `NONE`.
    (Optional) `branches` - A set of branch name patterns to restrict deployments to when the restriction type is `CUSTOM`.
    (Optional) `tags` - A set of tag name patterns to restrict deployments to when the restriction type is `CUSTOM`.
  EOF
  type = object({
    restriction = optional(string, "NONE")
    branches    = optional(set(string), [])
    tags        = optional(set(string), [])
  })
  default  = {}
  nullable = false

  validation {
    condition     = contains(["NONE", "PROTECTED_BRANCH", "CUSTOM"], var.deployment_policy.restriction)
    error_message = "Valid values for `restriction` are `NONE`, `PROTECTED_BRANCH`, or `CUSTOM`."
  }
}

variable "variables" {
  description = "(Optional) A map of GitHub Actions variables to set for the environment. Defaults to `{}`."
  type        = map(string)
  default     = {}
  nullable    = false
}

variable "secrets" {
  description = "(Optional) A map of GitHub Actions secrets to set for the environment. Currently, all values will be ignored and treated as placeholders. You should mange the secrets manually in GitHub after the environment is created. Defaults to `{}`."
  type        = map(string)
  default     = {}
  nullable    = false
}
