variable "name" {
  description = "(Required) The name of the organization."
  type        = string
  nullable    = false
}

variable "owners" {
  description = "(Optional) A list of usernames to add users as `admin` role. When applied, an invitation will be sent to the user to become an owner of the organization."
  type        = set(string)
  default     = []
  nullable    = false
}

variable "members" {
  description = "(Optional) A list of usernames to add users as `member` role. When applied, an invitation will be sent to the user to become a member of the organization."
  type        = set(string)
  default     = []
  nullable    = false
}

variable "blocked_users" {
  description = "(Optional) A list of usernames to block from organization."
  type        = set(string)
  default     = []
  nullable    = false
}

variable "security_manager_teams" {
  description = "(Optional) A list of team slugs to add as security manager teams. Grant a team permission to manage security alerts and settings across the organization. This team will also be granted read access to all repositories."
  type        = set(string)
  default     = []
  nullable    = false
}
