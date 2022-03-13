output "name" {
  description = "The name of the organization."
  value       = data.github_organization.this.login
}

output "display_name" {
  description = "The display name of the organization."
  value       = data.github_organization.this.name
}

output "id" {
  description = "The ID of the organization."
  value       = data.github_organization.this.id
}

output "description" {
  description = "The description of the organization."
  value       = data.github_organization.this.description
}

output "plan" {
  description = "The billing plan of the organization."
  value       = data.github_organization.this.plan
}

output "owners" {
  description = "A list of the owners of the organization."
  value       = var.owners
}

output "members" {
  description = "A list of the members of the organization."
  value       = var.members
}

output "all_members" {
  description = "A list of all members of the organization."
  value       = data.github_organization.after.members
}

output "repositories" {
  description = "A list of the repositories of the organization."
  value       = data.github_organization.this.repositories
}

output "blocked_users" {
  description = "A list of blocked usernames from organization."
  value       = var.blocked_users
}
