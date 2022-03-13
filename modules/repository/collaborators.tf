locals {
  read_collaborators = [
    for collaborator in var.read_collaborators : {
      username   = collaborator
      permission = "pull"
    }
  ]
  triage_collaborators = [
    for collaborator in var.triage_collaborators : {
      username   = collaborator
      permission = "triage"
    }
  ]
  write_collaborators = [
    for collaborator in var.write_collaborators : {
      username   = collaborator
      permission = "push"
    }
  ]
  maintain_collaborators = [
    for collaborator in var.maintain_collaborators : {
      username   = collaborator
      permission = "maintain"
    }
  ]
  admin_collaborators = [
    for collaborator in var.admin_collaborators : {
      username   = collaborator
      permission = "admin"
    }
  ]

  collaborators = concat(
    local.read_collaborators,
    local.triage_collaborators,
    local.write_collaborators,
    local.maintain_collaborators,
    local.admin_collaborators,
  )
}


###################################################
# Collaborators for GitHub Repository
###################################################

resource "github_repository_collaborator" "this" {
  for_each = {
    for collaborator in local.collaborators :
    collaborator.username => collaborator
  }

  repository = github_repository.this.name
  username   = each.key
  permission = each.value.permission

  permission_diff_suppression = true
}
