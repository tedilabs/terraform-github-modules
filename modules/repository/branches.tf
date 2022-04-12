resource "github_branch_default" "this" {
  count = var.default_branch != null ? 1 : 0

  repository = github_repository.this.name
  branch     = var.default_branch

  depends_on = [github_branch.this]
}

resource "github_branch" "this" {
  for_each = toset(var.branches)

  repository = github_repository.this.name
  branch     = each.value
}
