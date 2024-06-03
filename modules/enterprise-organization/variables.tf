variable "enterprise" {
  description = "(Required) The name (slug) of the enterprise."
  type        = string
  nullable    = false
}

variable "name" {
  description = "(Required) The name of the organization."
  type        = string
  nullable    = false
}

variable "display_name" {
  description = "(Optional) The display name of the organization. If not set, the `name` will be used as the `display_name`."
  type        = string
  default     = ""
  nullable    = false
}

variable "description" {
  description = "(Optional) The description of the organization."
  type        = string
  default     = "Managed by Terraform."
  nullable    = false
}

variable "owners" {
  description = "(Optional) A list of usernames to add users as `owner` role."
  type        = set(string)
  default     = []
  nullable    = false
}

variable "billing_email" {
  description = "(Required) The billing email address."
  type        = string
  nullable    = false
}
