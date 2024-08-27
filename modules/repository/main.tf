# INFO: Use a separate resource
# - `topics`
resource "github_repository" "this" {
  name         = var.name
  description  = var.description
  homepage_url = var.homepage

  visibility         = var.visibility
  is_template        = var.is_template
  archived           = var.archived
  archive_on_destroy = var.archive_on_destroy

  auto_init          = try(var.template.init_readme, false)
  license_template   = try(var.template.license, null)
  gitignore_template = try(var.template.gitignore, null)

  dynamic "template" {
    for_each = try([var.template.repository], [])

    content {
      owner      = split("/", template.value)[0]
      repository = split("/", template.value)[1]
    }
  }

  has_issues   = contains(var.features, "ISSUES")
  has_projects = contains(var.features, "PROJECTS")
  has_wiki     = contains(var.features, "WIKI")

  allow_merge_commit = contains(var.merge_strategies, "MERGE_COMMIT")
  allow_squash_merge = contains(var.merge_strategies, "SQUASH")
  allow_rebase_merge = contains(var.merge_strategies, "REBASE")

  delete_branch_on_merge = var.delete_branch_on_merge
  vulnerability_alerts   = var.vulnerability_alerts

  dynamic "pages" {
    for_each = var.pages_enabled ? ["go"] : []

    content {
      source {
        branch = var.pages_source_branch
        path   = var.pages_source_path
      }
      cname = try(var.pages_cname, null)
    }
  }

  lifecycle {
    ignore_changes = [
      auto_init,
      license_template,
      gitignore_template,
      template,
      topics,
    ]
  }
}
