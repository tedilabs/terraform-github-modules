variable "name" {
  description = "(Required) The name of the organization."
  type        = string
}

variable "owners" {
  description = "(Optional) A list of usernames to add users as `admin` role. When applied, an invitation will be sent to the user to become an owner of the organization."
  type        = set(string)
  default     = []
}

variable "members" {
  description = "(Optional) A list of usernames to add users as `member` role. When applied, an invitation will be sent to the user to become a member of the organization."
  type        = set(string)
  default     = []
}

variable "blocked_users" {
  description = "(Optional) A list of usernames to block from organization."
  type        = set(string)
  default     = []
}
