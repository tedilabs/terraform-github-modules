###################################################
# Deploy Keys for GitHub Repository
###################################################

resource "github_repository_deploy_key" "this" {
  for_each = {
    for deploy_key in var.deploy_keys :
    coalesce(deploy_key.name, md5(deploy_key.key)) => deploy_key
  }

  repository = github_repository.this.name
  title      = each.key
  key        = each.value.key
  read_only  = !each.value.writable
}
