data "github_organization" "this" {
  name = var.name
}

data "github_organization" "after" {
  name = var.name

  depends_on = [
    github_membership.this
  ]
}

locals {
  members = [
    for member in var.members : {
      username = member
      role     = "member"
    }
  ]
  owners = [
    for owner in var.owners : {
      username = owner
      role     = "admin"
    }
  ]
  membership = concat(local.members, local.owners)
}


###################################################
# Membership of GitHub Organization
###################################################

resource "github_membership" "this" {
  for_each = {
    for member in local.membership :
    member.username => member
  }

  username = each.key
  role     = each.value.role
}


###################################################
# Blocked Users of GitHub Organization
###################################################

resource "github_organization_block" "this" {
  for_each = toset(var.blocked_users)

  username = each.key
}
