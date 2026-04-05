variable "name" {
  description = "(Required) The name of the custom property."
  type        = string
  nullable    = false
}

variable "description" {
  description = "(Optional) The description of the custom property."
  type        = string
  default     = ""
  nullable    = false
}

variable "type" {
  description = "(Required) The type of the custom property. Can be one of `STRING`, `SINGLE_SELECT`, `MULTI_SELECT`, or `BOOL`. Defaults to `STRING`."
  type        = string
  default     = "STRING"
  nullable    = false

  validation {
    condition     = contains(["STRING", "SINGLE_SELECT", "MULTI_SELECT", "BOOL"], var.type)
    error_message = "Valid values for `type` are `STRING`, `SINGLE_SELECT`, `MULTI_SELECT`, or `BOOL`."
  }
}

variable "required" {
  description = "(Optional) Whether the custom property is required. Defaults to `false`."
  type        = bool
  default     = false
  nullable    = false
}

variable "allowed_values" {
  description = "(Optional) A set of allowed values for the custom property. This is required if the `type` is `SINGLE_SELECT` or `MULTI_SELECT`."
  type        = set(string)
  default     = []
  nullable    = false

  validation {
    condition = anytrue([
      contains(["SINGLE_SELECT", "MULTI_SELECT"], var.type) && length(var.allowed_values) > 0,
      !contains(["SINGLE_SELECT", "MULTI_SELECT"], var.type),
    ])
    error_message = "`allowed_values` must be provided and contain at least one value when `type` is `SINGLE_SELECT` or `MULTI_SELECT`. It must be empty when `type` is `STRING` or `BOOL`."
  }
}

variable "default" {
  description = "(Optional) The default value of the custom property."
  type        = any
  default     = null
  nullable    = true
}

variable "editable_by" {
  description = "(Optional) Who can edit the values of the custom property. Can be one of `ORG_ACTORS` or `ORG_AND_REPO_ACTORS`. When set to `ORG_ACTORS` (the default), only organization owners can edit the property values on repositories. When set to `ORG_AND_REPO_ACTORS`, both organization owners and repository administrators with the custom properties permission can edit the values."
  type        = string
  default     = "ORG_ACTORS"
  nullable    = false
}
