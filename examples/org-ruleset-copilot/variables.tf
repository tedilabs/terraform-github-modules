variable "owner" {
  description = "(Required) The GitHub organization that owns the repositories."
  type        = string
  nullable    = false
}

variable "repositories" {
  description = "(Required) The names of the repositories to automatically review."
  type        = set(string)
  nullable    = false
}
