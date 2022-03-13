output "id" {
  description = "The ID of the GitHub repository."
  value       = github_repository.this.repo_id
}

output "node_id" {
  description = "The node ID of the GitHub repository. This is GraphQL global node id for use with v4 API."
  value       = github_repository.this.node_id
}

output "name" {
  description = "The name of the repository."
  value       = github_repository.this.name
}

output "full_name" {
  description = "The full name of the repository. A string of the form `orgname/reponame`"
  value       = github_repository.this.full_name
}

output "description" {
  description = "The description of the repository."
  value       = github_repository.this.description
}

output "homepage" {
  description = "A URL of the website for the repository."
  value       = github_repository.this.homepage_url
}

output "url" {
  description = "The URL of the repository."
  value       = github_repository.this.html_url
}

output "git_clone_url" {
  description = "The URL that can be provided to `git clone` to clone the repository anonymously via the git protocol."
  value       = github_repository.this.git_clone_url
}

output "http_clone_url" {
  description = "The URL that can be provided to `git clone` to clone the repository anonymously via HTTPS."
  value       = github_repository.this.http_clone_url
}

output "ssh_clone_url" {
  description = "The URL that can be provided to `git clone` to clone the repository anonymously via SSH."
  value       = github_repository.this.ssh_clone_url
}

output "visibility" {
  description = "The visibility of the repository. Can be `public`, `private` or `internal`."
  value       = github_repository.this.visibility
}

output "is_template" {
  description = "Whether this is a template repository."
  value       = github_repository.this.is_template
}

output "archived" {
  description = "Whether the repository is archived."
  value       = github_repository.this.archived
}

output "template" {
  description = "The template of the repository."
  value       = var.template
}

output "features" {
  description = "A list of available features on the repository."
  value       = var.features
}

output "merge_strategies" {
  description = "A list of available strategies for merging pull requests on the repository."
  value       = var.merge_strategies
}

output "delete_branch_on_merge" {
  description = "Automatically delete head branch after a pull request is merged."
  value       = github_repository.this.delete_branch_on_merge
}

output "topics" {
  description = "A list of topics for the repository."
  value       = github_repository.this.topics
}

output "issue_labels" {
  description = "A list of issue labels for the repository."
  value = [
    for label in github_issue_label.this : {
      name        = label.name
      color       = label.color
      description = label.description
    }
  ]
}

output "permissions" {
  description = "The access control list which manage individual and team access to the repository."
  value = {
    read = {
      teams         = var.read_teams
      collaborators = var.read_collaborators
    }
    triage = {
      teams         = var.triage_teams
      collaborators = var.triage_collaborators
    }
    write = {
      teams         = var.write_teams
      collaborators = var.write_collaborators
    }
    maintain = {
      teams         = var.maintain_teams
      collaborators = var.maintain_collaborators
    }
    admin = {
      teams         = var.admin_teams
      collaborators = var.admin_collaborators
    }
  }
}

output "default_branch" {
  description = "The default branch of the repository."
  value       = one(github_branch_default.this.*.branch)
}

output "deploy_keys" {
  description = "A list of deploy keys granted access to the repository."
  value = {
    for key in var.deploy_keys :
    key.name => key
  }
}
