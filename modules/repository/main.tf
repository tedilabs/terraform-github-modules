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

  topics = var.topics

  lifecycle {
    ignore_changes = [
      auto_init,
      license_template,
      gitignore_template,
      template,
    ]
  }
}

resource "github_branch_default" "this" {
  count = var.default_branch != null ? 1 : 0

  repository = github_repository.this.name
  branch     = var.default_branch
}
