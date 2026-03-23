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

variable "allows_self_approval" {
  description = "(Optional) Whether to allow users to approve their own deployment. The default value is `false`."
  type        = bool
  default     = false
  nullable    = false
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
