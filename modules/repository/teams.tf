locals {
  read_teams = [
    for team in var.read_teams : {
      team_id    = team
      permission = "pull"
    }
  ]
  triage_teams = [
    for team in var.triage_teams : {
      team_id    = team
      permission = "triage"
    }
  ]
  write_teams = [
    for team in var.write_teams : {
      team_id    = team
      permission = "push"
    }
  ]
  maintain_teams = [
    for team in var.maintain_teams : {
      team_id    = team
      permission = "maintain"
    }
  ]
  admin_teams = [
    for team in var.admin_teams : {
      team_id    = team
      permission = "admin"
    }
  ]

  teams = concat(
    local.read_teams,
    local.triage_teams,
    local.write_teams,
    local.maintain_teams,
    local.admin_teams,
  )
}


###################################################
# Teams for GitHub Repository
###################################################

resource "github_team_repository" "this" {
  for_each = {
    for team in local.teams :
    team.team_id => team
  }

  repository = github_repository.this.name
  team_id    = each.key
  permission = each.value.permission
}
