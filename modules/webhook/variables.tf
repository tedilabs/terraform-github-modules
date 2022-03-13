variable "url" {
  description = "(Required) The URL of the webhook."
  type        = string
}

variable "content_type" {
  description = "(Optional) The content type for the webhook payload. Valid values are either `FORM` or `JSON`."
  type        = string
  default     = "JSON"

  validation {
    condition     = contains(["FORM", "JSON"], var.content_type)
    error_message = "Available content-type: `FORM`, `JSON`."
  }
}

variable "ssl_enabled" {
  description = "(Optional) Whether to verify SSL certificates when delivering payloads. Default is true."
  type        = bool
  default     = true
}

variable "secret" {
  description = "(Optional) The shared secret for the webhook."
  type        = string
  default     = ""
  sensitive   = true
}

variable "repositories" {
  description = "(Optional) A list of repositories to create the webhook for. Create an organization-level webhook if you provide `*`."
  type        = set(string)
  default     = ["*"]
}

# INFO: https://docs.github.com/en/developers/webhooks-and-events/webhooks/webhook-events-and-payloads
variable "events" {
  description = "(Optional) A list of events which should trigger the webhook. Default is for only `push` event."
  type        = set(string)
  default     = ["push"]
}

variable "enabled" {
  description = "(Optional) Whether to activate the webhook should receive events."
  type        = bool
  default     = true
}
