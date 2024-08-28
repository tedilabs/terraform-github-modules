# INFO: Not supported attributes
# - `private`
# - `has_downloads`
# INFO: Use a separate resource
# - `topics`
# - `default_branch`
resource "github_repository" "this" {
  name         = var.name
  description  = var.description
  homepage_url = var.homepage

  visibility         = var.visibility
  archived           = var.archived
  archive_on_destroy = var.archive_on_destroy


  ## Template
  is_template = var.is_template

  auto_init          = var.template.init_readme
  license_template   = var.template.license
  gitignore_template = var.template.gitignore

  dynamic "template" {
    for_each = var.template.repository != null ? [var.template.repository] : []

    content {
      owner      = split("/", template.value)[0]
      repository = split("/", template.value)[1]
    }
  }


  ## Features
  has_issues   = contains(var.features, "ISSUES")
  has_projects = contains(var.features, "PROJECTS")
  has_wiki     = contains(var.features, "WIKI")


  ## Pull Request
  allow_merge_commit = contains(var.merge_strategies, "MERGE_COMMIT")
  allow_squash_merge = contains(var.merge_strategies, "SQUASH")
  allow_rebase_merge = contains(var.merge_strategies, "REBASE")

  allow_auto_merge       = var.auto_merge_enabled
  delete_branch_on_merge = var.delete_branch_on_merge
  vulnerability_alerts   = var.vulnerability_alerts


  ## Pages
  dynamic "pages" {
    for_each = var.pages.enabled ? [var.pages] : []

    content {
      source {
        branch = pages.value.source.branch
        path   = pages.value.source.path
      }
      cname = pages.value.cname
    }
  }

  lifecycle {
    ignore_changes = [
      auto_init,
      license_template,
      gitignore_template,
      template,
      topics,
      has_downloads,
    ]
  }
}
