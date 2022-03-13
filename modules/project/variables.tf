variable "name" {
  description = "(Required) The name of the project."
  type        = string
}

variable "description" {
  description = "(Optional) A description of the project."
  type        = string
  default     = "Managed by Terraform."
}

variable "level" {
  description = "(Optional) Choose to create a project for organization or repository. Valid values are `ORGANIAZTION` and `REPOSITORY`. The default is `ORGANIZATION` level, so the project is managed by organization level."
  type        = string
  default     = "ORGANIZATION"

  validation {
    condition     = contains(["REPOSITORY", "ORGANIZATION"], var.level)
    error_message = "The level should be one of `REPOSITORY`, `ORGANIZATION`."
  }
}

variable "repository" {
  description = "(Optional) The repository to create the project for. Only need when `level` is `REPOSITORY`."
  type        = string
  default     = null
}

variable "columns" {
  description = "(Optional) A list of columns for the project."
  type        = set(string)
  default     = []
}
