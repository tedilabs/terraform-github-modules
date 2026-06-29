output "id" {
  description = "The ID of the organization ruleset."
  value       = github_organization_ruleset.this.id
}

output "ruleset_id" {
  description = "The GitHub-assigned numeric ID of the organization ruleset."
  value       = github_organization_ruleset.this.ruleset_id
}

output "node_id" {
  description = "The node ID of the organization ruleset."
  value       = github_organization_ruleset.this.node_id
}

output "name" {
  description = "The name of the organization ruleset."
  value       = github_organization_ruleset.this.name
}

output "target" {
  description = "The target of the organization ruleset."
  value       = github_organization_ruleset.this.target
}

output "status" {
  description = "The status (enforcement level) of the organization ruleset."
  value       = upper(github_organization_ruleset.this.enforcement)
}

output "bypass_list" {
  description = "The list of actors that are allowed to bypass the rules of the ruleset."
  value       = var.bypass_list
}

output "conditions" {
  description = "The conditions that determine which repositories and refs the ruleset applies to."
  value       = var.conditions
}

output "rules" {
  description = "The rules enforced by the ruleset."
  value       = var.rules
}
