resource "github_team" "this" {
  name        = var.name
  description = try(var.description, null)
  privacy     = var.is_secret ? "secret" : "closed"

  parent_team_id            = try(var.parent_id, null)
  create_default_maintainer = var.default_maintainer_enabled

  ldap_dn = try(var.ldap_group_dn, null)
}

locals {
  members = [
    for member in var.members : {
      username = member
      role     = "member"
    }
  ]
  maintainers = [
    for maintainer in var.maintainers : {
      username = maintainer
      role     = "maintainer"
    }
  ]
  membership = concat(local.members, local.maintainers)
}


###################################################
# Membership of GitHub Organization Team
###################################################

resource "github_team_membership" "this" {
  for_each = {
    for member in local.membership :
    member.username => member
  }

  team_id  = github_team.this.id
  username = each.key
  role     = each.value.role
}
