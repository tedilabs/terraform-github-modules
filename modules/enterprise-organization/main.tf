data "github_enterprise" "this" {
  slug = var.enterprise
}


###################################################
# Organization of GitHub Enterprise
###################################################

resource "github_enterprise_organization" "this" {
  enterprise_id = data.github_enterprise.this.id

  name         = var.name
  display_name = coalesce(var.display_name, var.name)
  description  = var.description

  admin_logins  = var.owners
  billing_email = var.billing_email
}
