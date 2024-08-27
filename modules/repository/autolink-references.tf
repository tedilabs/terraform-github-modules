###################################################
# Auto-link References for GitHub Repository
###################################################

resource "github_repository_autolink_reference" "this" {
  for_each = {
    for reference in var.autolink_references :
    reference.key_prefix => reference
  }

  repository = github_repository.this.name

  key_prefix          = each.key
  target_url_template = each.value.target_url_template
  is_alphanumeric     = each.value.is_alphanumeric
}
