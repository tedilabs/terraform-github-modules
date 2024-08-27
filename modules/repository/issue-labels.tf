###################################################
# Issue Labels for GitHub Repository
###################################################

resource "github_issue_label" "this" {
  for_each = {
    for label in var.issue_labels :
    label.name => label
  }

  repository = github_repository.this.name

  name        = each.key
  color       = each.value.color
  description = each.value.description
}
