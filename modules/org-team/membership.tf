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
    for member in(!var.membership_sync_enabled ? local.membership : []) :
    member.username => member
  }

  team_id  = github_team.this.id
  username = each.key
  role     = each.value.role
}

resource "github_team_members" "this" {
  count = var.membership_sync_enabled ? 1 : 0

  team_id = github_team.this.id

  dynamic "members" {
    for_each = local.membership
    iterator = member

    content {
      username = member.value.username
      role     = member.value.role
    }
  }
}
