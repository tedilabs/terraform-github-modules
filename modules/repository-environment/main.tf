###################################################
# Environment of GitHub Repository
###################################################

resource "github_repository_environment" "this" {
  repository = var.repository

  environment = var.name

  wait_timer          = var.wait_timer
  can_admins_bypass   = var.allow_admin_to_bypass
  prevent_self_review = !var.allows_self_approval
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
