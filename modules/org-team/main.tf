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
# GitHub Organization Team
###################################################

resource "github_team" "this" {
  name        = var.name
  description = var.description
  privacy     = var.is_secret ? "secret" : "closed"

  parent_team_id            = var.parent_id
  create_default_maintainer = var.default_maintainer_enabled

  ldap_dn = var.ldap_group_dn
}


###################################################
# Settings for GitHub Organization Team
###################################################

resource "github_team_settings" "this" {
  team_id = github_team.this.id

  dynamic "review_request_delegation" {
    for_each = var.code_review_auto_assignment.enabled ? [var.code_review_auto_assignment] : []
    iterator = review

    content {
      algorithm    = review.value.algorithm
      member_count = review.value.assignment_count
      notify       = review.value.notify_team_enabled
    }
  }
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
