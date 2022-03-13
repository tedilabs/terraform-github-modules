resource "github_organization_project" "this" {
  count = var.level == "ORGANIZATION" ? 1 : 0

  name = var.name
  body = var.description
}

resource "github_repository_project" "this" {
  count = var.level == "REPOSITORY" ? 1 : 0

  repository = var.repository

  name = var.name
  body = var.description
}


###################################################
# Columns for GitHub Project
###################################################

resource "github_project_column" "this" {
  for_each = toset(var.columns)

  project_id = try(github_repository_project.this[0].id, github_organization_project.this[0].id)
  name       = each.key
}
