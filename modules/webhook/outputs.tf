output "url" {
  description = "The URL of the webhook."
  value       = var.url
}

output "content_type" {
  description = "The content type of the webhook payload."
  value = try(
    upper(github_organization_webhook.this[0].configuration[0].content_type),
    upper(values(github_repository_webhook.this)[0].configuration[0].content_type),
  )
}

output "ssl_enabled" {
  description = "Whether SSL verification is enabled."
  value = try(
    !github_organization_webhook.this[0].configuration[0].insecure_ssl,
    !values(github_repository_webhook.this)[0].configuration[0].insecure_ssl,
  )
}

output "repositories" {
  description = "A list of repositories which the webhook is for."
  value       = local.is_organization ? ["*"] : local.repositories
}

output "events" {
  description = "A list of events which trigger the webhook."
  value = try(
    github_organization_webhook.this[0].events,
    values(github_repository_webhook.this)[0].events,
  )
}

output "enabled" {
  description = "Whether the webhook is enabled."
  value       = var.enabled
}
