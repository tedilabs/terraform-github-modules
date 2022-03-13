###################################################
# Deploy Keys for GitHub Repository
###################################################

resource "github_repository_deploy_key" "this" {
  for_each = {
    for key in var.deploy_keys :
    key.name => key
  }

  repository = github_repository.this.name
  title      = try(each.key, md5(each.value.key))
  key        = each.value.key
  read_only  = try(!each.value.writable, true)
}
