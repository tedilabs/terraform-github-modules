variable "name" {
  description = "(Required) The name of the team."
  type        = string
}

variable "description" {
  description = "(Optional) A description of the team."
  type        = string
  default     = "Managed by Terraform."
}

variable "is_secret" {
  description = "(Optional) If true, team is only visible to the people on the team and people with owner permissions."
  type        = bool
  default     = false
}

variable "parent_id" {
  description = "(Optional) The ID of the parent team, if this is a nested team."
  type        = string
  default     = null
}

variable "default_maintainer_enabled" {
  description = "(Optional) If true, adds the creating user as a default maintainer to the team."
  type        = bool
  default     = false
}

variable "ldap_group_dn" {
  description = "(Optional) The LDAP Distinguished Name of the group where membership will be synchronized. Only available in GitHub Enterprise Server."
  type        = string
  default     = null
}

variable "maintainers" {
  description = "(Optional) A list of usernames to add users as `maintainer` role. When applied, the user will become a maintainer of the team."
  type        = set(string)
  default     = []
}

variable "members" {
  description = "(Optional) A list of usernames to add users as `member` role. When applied, the user will become a member of the team."
  type        = set(string)
  default     = []
}
