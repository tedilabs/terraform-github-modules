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
  allow_self_approval   = each.value.allow_self_approval

  reviewers = [
    for reviewer in each.value.reviewers :
    {
      type = reviewer.type
      name = reviewer.name
    }
  ]
  deployment_policy = {
    restriction = each.value.deployment_policy.restriction
    branches    = each.value.deployment_policy.branches
    tags        = each.value.deployment_policy.tags
  }


  ## Variables & Secrets
  variables = each.value.variables
  secrets   = each.value.secrets
}
