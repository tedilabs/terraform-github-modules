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
