output "id" {
  description = "The ID of the custom property."
  value       = github_organization_custom_properties.this.id
}

output "name" {
  description = "The name of the custom property."
  value       = github_organization_custom_properties.this.property_name
}

output "description" {
  description = "The description of the custom property."
  value       = github_organization_custom_properties.this.description
}

output "type" {
  description = "The type of the custom property."
  value = {
    for k, v in local.value_types :
    v => k
  }[github_organization_custom_properties.this.value_type]
}

output "required" {
  description = "Whether the custom property is required."
  value       = github_organization_custom_properties.this.required
}

output "allowed_values" {
  description = "A set of allowed values for the custom property."
  value       = github_organization_custom_properties.this.allowed_values
}

output "default" {
  description = "The default value of the custom property."
  value       = github_organization_custom_properties.this.default_value
}

output "editable_by" {
  description = "The configuration for deployment policy of the environment."
  value       = upper(github_organization_custom_properties.this.values_editable_by)
}

# output "debug" {
#   value = {
#     for k, v in github_organization_custom_properties.this :
#     k => v
#     if !contains(["id", "property_name", "description", "value_type", "required", "allowed_values", "default_value", "values_editable_by"], k)
#   }
# }
