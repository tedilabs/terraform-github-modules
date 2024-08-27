locals {
  default_roles = {
    "read"     = "pull"
    "triage"   = "triage"
    "write"    = "push"
    "maintain" = "maintain"
    "admin"    = "admin"
  }

  unsynced_collaborators = (!var.access.sync_enabled
    ? var.access.collaborators
    : []
  )
  unsynced_teams = (!var.access.sync_enabled
    ? var.access.teams
    : []
  )
}

###################################################
# Collaborator Access to GitHub Repository
###################################################

resource "github_repository_collaborator" "this" {
  for_each = {
    for collaborator in local.unsynced_collaborators :
    collaborator.username => collaborator
  }

  repository = github_repository.this.name
  username   = each.key
  permission = (contains(keys(local.default_roles), each.value.role)
    ? local.default_roles[each.value.role]
    : each.value.role
  )

  permission_diff_suppression = true
}


###################################################
# Team Access to GitHub Repository
###################################################

resource "github_team_repository" "this" {
  for_each = {
    for team in local.unsynced_teams :
    team.team => team
  }

  repository = github_repository.this.name
  team_id    = each.key
  permission = (contains(keys(local.default_roles), each.value.role)
    ? local.default_roles[each.value.role]
    : each.value.role
  )
}


###################################################
# Access to GitHub Repository with Sync
###################################################

resource "github_repository_collaborators" "this" {
  count = var.access.sync_enabled ? 1 : 0

  repository = github_repository.this.name

  dynamic "user" {
    for_each = var.access.collaborators
    iterator = collaborator

    content {
      username = collaborator.value.username
      permission = (contains(keys(local.default_roles), collaborator.value.role)
        ? local.default_roles[collaborator.value.role]
        : collaborator.value.role
      )
    }
  }

  dynamic "team" {
    for_each = var.access.teams

    content {
      team_id = team.value.team
      permission = (contains(keys(local.default_roles), team.value.role)
        ? local.default_roles[team.value.role]
        : team.value.role
      )
    }
  }
}
