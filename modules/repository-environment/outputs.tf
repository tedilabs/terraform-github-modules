output "repository" {
  description = "The repository name which the environment belongs to."
  value       = github_repository_environment.this.repository
}

output "name" {
  description = "The name of the environment."
  value       = github_repository_environment.this.environment
}

output "wait_timer" {
  description = "The amount of time in minutes to wait before allowing deployments to proceed."
  value       = github_repository_environment.this.wait_timer
}

output "allow_admin_to_bypass" {
  description = "Whether to allow admins to bypass the wait timer and deployment review."
  value       = github_repository_environment.this.can_admins_bypass
}

output "allows_self_approval" {
  description = "Whether to allow users to approve their own deployment."
  value       = !github_repository_environment.this.prevent_self_review
}

# output "debug" {
#   value = {
#     for k, v in github_repository_environment.this :
#     k => v
#     if !contains(["repository", "environment", "wait_timer", "can_admins_bypass", "prevent_self_review"], k)
#   }
# }
