locals {
  is_organization = contains(var.repositories, "*")
  repositories    = local.is_organization ? [] : var.repositories
}

resource "github_organization_webhook" "this" {
  count = local.is_organization ? 1 : 0

  events = var.events
  active = var.enabled

  configuration {
    url          = var.url
    content_type = lower(var.content_type)
    insecure_ssl = !var.ssl_enabled

    secret = var.secret
  }
}

resource "github_repository_webhook" "this" {
  for_each = local.repositories

  repository = each.key

  events = var.events
  active = var.enabled

  configuration {
    url          = var.url
    content_type = lower(var.content_type)
    insecure_ssl = !var.ssl_enabled

    secret = var.secret
  }
}
