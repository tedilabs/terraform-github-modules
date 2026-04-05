locals {
  value_types = {
    "STRING"        = "string"
    "SINGLE_SELECT" = "single_select"
    "MULTI_SELECT"  = "multi_select"
    "BOOL"          = "true_false"
  }
}


###################################################
# Custom Property of GitHub Repository
###################################################

resource "github_organization_custom_properties" "this" {
  property_name = var.name
  description   = var.description

  value_type     = local.value_types[var.type]
  required       = var.required
  allowed_values = var.allowed_values
  default_value  = var.default

  values_editable_by = lower(var.editable_by)
}
