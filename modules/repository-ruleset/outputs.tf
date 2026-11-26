output "repository" {
  description = "The repository name which the ruleset belongs to."
  value       = github_repository_ruleset.this.repository
}

output "id" {
  description = "The ID of the repository ruleset."
  value       = github_repository_ruleset.this.id
}

output "ruleset_id" {
  description = "The GitHub-assigned numeric ID of the repository ruleset."
  value       = github_repository_ruleset.this.ruleset_id
}

output "node_id" {
  description = "The node ID of the repository ruleset."
  value       = github_repository_ruleset.this.node_id
}

output "name" {
  description = "The name of the repository ruleset."
  value       = github_repository_ruleset.this.name
}

output "target" {
  description = "The target of the repository ruleset."
  value       = github_repository_ruleset.this.target
}

output "status" {
  description = "The status (enforcement level) of the repository ruleset."
  value       = upper(github_repository_ruleset.this.enforcement)
}

output "conditions" {
  description = "The conditions that determine which refs the ruleset applies to."
  value       = var.conditions
}

output "rules" {
  description = "The rules enforced by the ruleset."
  value       = var.rules
}
