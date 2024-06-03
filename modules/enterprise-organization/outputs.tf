output "enterprise" {
  description = "The information of the enterprise which the organization belongs to."
  value = {
    id   = github_enterprise_organization.this.enterprise_id
    name = var.enterprise
  }
}

output "id" {
  description = "The ID of the organization."
  value       = github_enterprise_organization.this.id
}

output "database_id" {
  description = "The database ID of the organization."
  value       = github_enterprise_organization.this.database_id
}

output "name" {
  description = "The name of the organization."
  value       = github_enterprise_organization.this.name
}

output "display_name" {
  description = "The display name of the organization."
  value       = github_enterprise_organization.this.display_name
}

output "description" {
  description = "The description of the organization."
  value       = github_enterprise_organization.this.description
}

output "owners" {
  description = "A list of organization owner usernames."
  value       = github_enterprise_organization.this.admin_logins
}

output "billing_email" {
  description = "The billing email address."
  value       = github_enterprise_organization.this.billing_email
}

# output "debug" {
#   value = {
#     for k, v in github_enterprise_organization.this :
#     k => v
#     if !contains(["id", "name", "display_name", "description", "admin_logins", "billing_email", "database_id", "enterprise_id"], k)
#   }
# }
