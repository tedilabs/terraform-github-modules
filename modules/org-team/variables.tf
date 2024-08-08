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

variable "parent_id" {
  description = "(Optional) The ID of the parent team, if this is a nested team."
  type        = string
  default     = null
  nullable    = true
}

variable "default_maintainer_enabled" {
  description = "(Optional) If true, adds the creating user as a default maintainer to the team. Defaults to `false`."
  type        = bool
  default     = false
  nullable    = false
}

variable "ldap_group_dn" {
  description = "(Optional) The LDAP Distinguished Name of the group where membership will be synchronized. Only available in GitHub Enterprise Server."
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
