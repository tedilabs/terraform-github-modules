###################################################
# GitHub Organization Team
###################################################
# INFO: Deprecated attributes
# - `create_default_maintainer`
resource "github_team" "this" {
  name                 = var.name
  description          = var.description
  privacy              = var.is_secret ? "secret" : "closed"
  notification_setting = var.notification_enabled ? "notifications_enabled" : "notifications_disabled"

  parent_team_id = var.parent_id

  ldap_dn = var.ldap_group_dn
}


###################################################
# Identity Provider Groups for GitHub Organization Team Sync
###################################################

data "github_organization_team_sync_groups" "this" {
  count = var.identity_provider_team_sync.enabled ? 1 : 0
}

locals {
  idp_groups = (var.identity_provider_team_sync.enabled
    ? {
      for group in data.github_organization_team_sync_groups.this[0].groups :
      group.group_name => {
        id          = group.group_id
        name        = group.group_name
        description = group.group_description
      }
    }
    : {}
  )
}

resource "github_team_sync_group_mapping" "this" {
  count = var.identity_provider_team_sync.enabled ? 1 : 0

  team_slug = github_team.this.slug

  dynamic "group" {
    for_each = var.identity_provider_team_sync.groups

    content {
      group_id          = local.idp_groups[group.value].id
      group_name        = local.idp_groups[group.value].name
      group_description = local.idp_groups[group.value].description
    }
  }
}
