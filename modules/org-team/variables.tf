variable "name" {
  description = "(Required) The name of the team."
  type        = string
  nullable    = false
}

variable "description" {
  description = "(Optional) A description of the team."
  type        = string
  default     = "Managed by Terraform."
  nullable    = false
}

variable "is_secret" {
  description = "(Optional) If true, team is only visible to the people on the team and people with owner permissions. Defaults to `false`."
  type        = bool
  default     = false
  nullable    = false
}

variable "notification_enabled" {
  description = "(Optional) Whether to enable notifications for the team. Defaults to `true`."
  type        = bool
  default     = true
  nullable    = false
}

variable "parent_id" {
  description = "(Optional) The ID of the parent team, if this is a nested team."
  type        = string
  default     = null
  nullable    = true
}

variable "maintainers" {
  description = "(Optional) A list of usernames to add users as `maintainer` role. When applied, the user will become a maintainer of the team."
  type        = set(string)
  default     = []
  nullable    = false

  validation {
    condition     = length(setintersection(var.maintainers, var.members)) == 0
    error_message = "The same user cannot be a member and a maintainer of the team."
  }
}

variable "members" {
  description = "(Optional) A list of usernames to add users as `member` role. When applied, the user will become a member of the team."
  type        = set(string)
  default     = []
  nullable    = false
}

variable "membership_sync_enabled" {
  description = "(Optional) Whether to sync the members of the team. Members added outside of the Terraform code will be removed. Defaults to `false`."
  type        = bool
  default     = false
  nullable    = false
}

variable "identity_provider_team_sync" {
  description = <<EOT
  (Optional) A configuration to manage team members using your identity provider groups. `identity_provider_team_sync` block as defined below.
    (Optional) `enabled` - Whether to enable team synchronization between your identity provider (IdP) and your organization on GitHub. Defaults to `false`.
    (Optional) `groups` - A set of group names to sync with the team.
  EOT
  type = object({
    enabled = optional(bool, false)
    groups  = optional(set(string), [])
  })
  default  = {}
  nullable = false
}

variable "ldap_group_dn" {
  description = "(Optional) The LDAP Distinguished Name of the group where membership will be synchronized. Only available in GitHub Enterprise Server."
  type        = string
  default     = null
  nullable    = true
}

variable "code_review_auto_assignment" {
  description = <<EOT
  (Optional) A configuration for code review auto assignment. `code_review_auto_assignment` block as defined below.
    (Optional) `enabled` - Whether to enable code review auto assignment. Defaults to `false`.
    (Optional) `algorithm` - The algorithm to use for code review auto assignment. Valid values are `ROUND_ROBIN` or `LOAD_BALANCE`. Defaults to `ROUND_ROBIN`.
    (Optional) `assignment_count` - The number of reviewers to assign for each pull request.
    (Optional) `notify_team_enabled` - Whether to notify the entire team when both a team and one or more of its members are requested for review. Defaults to `false`.
  EOT
  type = object({
    enabled          = optional(bool, false)
    algorithm        = optional(string, "ROUND_ROBIN")
    assignment_count = optional(number)

    notify_team_enabled = optional(bool, false)
  })
  default  = {}
  nullable = false

  validation {
    condition     = contains(["ROUND_ROBIN", "LOAD_BALANCE"], var.code_review_auto_assignment.algorithm)
    error_message = "Valid values of `algorithm` are `ROUND_ROBIN` or `LOAD_BALANCE`."
  }
  validation {
    condition = anytrue([
      var.code_review_auto_assignment.enabled == false,
      var.code_review_auto_assignment.enabled == true && var.code_review_auto_assignment.assignment_count != 0
    ])
    error_message = "The value of `assignment_count` must be greater than 0 when auto assignment is enabled."
  }
}
