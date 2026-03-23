###################################################
# Environments for GitHub Repository
###################################################

module "environment" {
  source = "../repository-environment"

  for_each = {
    for environment in var.environments :
    environment.name => environment
  }

  repository = github_repository.this.name
  name       = each.key

  wait_timer = each.value.wait_timer

  allow_admin_to_bypass = each.value.allow_admin_to_bypass
  allows_self_approval  = each.value.allows_self_approval


  ## Variables & Secrets
  variables = each.value.variables
  secrets   = each.value.secrets
}
