output "id" {
  description = "The ID of the team."
  value       = github_team.this.id
}

output "node_id" {
  description = "The Node ID of the team."
  value       = github_team.this.node_id
}

output "slug" {
  description = "The slug of the team."
  value       = github_team.this.slug
}

output "name" {
  description = "The name of the team."
  value       = github_team.this.name
}

output "description" {
  description = "The description of the team."
  value       = github_team.this.description
}

output "is_secret" {
  description = "Whether to be only visible to the people on the team and people with owner permissions."
  value       = var.is_secret
}

output "parent_id" {
  description = "The ID of the parent team."
  value       = github_team.this.parent_team_id
}

output "ldap_group_dn" {
  description = "The LDAP Distinguished Name of the group where membership will be synchronized."
  value       = var.ldap_group_dn
}

output "default_maintainer_enabled" {
  description = "Whether to add the creating user as a default maintainer."
  value       = github_team.this.create_default_maintainer
}

output "maintainers" {
  description = "A list of the maintainers of the team."
  value       = var.maintainers
}

output "members" {
  description = "A list of the members of the team."
  value       = var.members
}
