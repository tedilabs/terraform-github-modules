data "github_team" "this" {
  for_each = toset([
    for reviewer in var.reviewers :
    reviewer.name
    if reviewer.type == "TEAM"
  ])

  slug = each.value
}

data "github_user" "this" {
  for_each = toset([
    for reviewer in var.reviewers :
    reviewer.name
    if reviewer.type == "USER"
  ])

  username = each.value
}


###################################################
# Environment of GitHub Repository
###################################################

resource "github_repository_environment" "this" {
  repository = var.repository

  environment = var.name

  wait_timer          = var.wait_timer
  can_admins_bypass   = var.allow_admin_to_bypass
  prevent_self_review = !var.allow_self_approval

  reviewers {
    teams = values(data.github_team.this)[*].id
    users = values(data.github_user.this)[*].id
  }

  deployment_branch_policy {
    protected_branches     = var.deployment_policy.restriction == "PROTECTED_BRANCHES"
    custom_branch_policies = var.deployment_policy.restriction == "CUSTOM"
  }
}


###################################################
# Deployment Policy for Repository Environment
###################################################

resource "github_repository_environment_deployment_policy" "branch" {
  for_each = (var.deployment_policy.restriction == "CUSTOM"
    ? var.deployment_policy.branches
    : []
  )

  repository  = var.repository
  environment = github_repository_environment.this.environment

  branch_pattern = each.value
}

resource "github_repository_environment_deployment_policy" "tag" {
  for_each = (var.deployment_policy.restriction == "CUSTOM"
    ? var.deployment_policy.tags
    : []
  )

  repository  = var.repository
  environment = github_repository_environment.this.environment

  tag_pattern = each.value
}


###################################################
# Variables for Repository Environment
###################################################

resource "github_actions_environment_variable" "this" {
  for_each = var.variables

  repository  = var.repository
  environment = github_repository_environment.this.environment

  variable_name = each.key
  value         = each.value
}


###################################################
# Secrets for Repository Environment
###################################################

resource "github_actions_environment_secret" "this" {
  for_each = var.secrets

  repository  = var.repository
  environment = github_repository_environment.this.environment

  secret_name     = each.key
  plaintext_value = "placeholder"
  # key_id          = var.key_id
  # encrypted_value = each.value

  lifecycle {
    ignore_changes = [plaintext_value]
  }
}
