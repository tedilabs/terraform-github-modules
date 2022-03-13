# webhook

This module creates following resources.

- `github_organization_webhook` (optional)
- `github_repository_webhook` (optional)

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.1 |
| <a name="requirement_github"></a> [github](#requirement\_github) | = 4.13.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_github"></a> [github](#provider\_github) | 4.13.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [github_organization_webhook.this](https://registry.terraform.io/providers/hashicorp/github/4.13.0/docs/resources/organization_webhook) | resource |
| [github_repository_webhook.this](https://registry.terraform.io/providers/hashicorp/github/4.13.0/docs/resources/repository_webhook) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_url"></a> [url](#input\_url) | (Required) The URL of the webhook. | `string` | n/a | yes |
| <a name="input_content_type"></a> [content\_type](#input\_content\_type) | (Optional) The content type for the webhook payload. Valid values are either `FORM` or `JSON`. | `string` | `"JSON"` | no |
| <a name="input_enabled"></a> [enabled](#input\_enabled) | (Optional) Whether to activate the webhook should receive events. | `bool` | `true` | no |
| <a name="input_events"></a> [events](#input\_events) | (Optional) A list of events which should trigger the webhook. Default is for only `push` event. | `set(string)` | <pre>[<br>  "push"<br>]</pre> | no |
| <a name="input_repositories"></a> [repositories](#input\_repositories) | (Optional) A list of repositories to create the webhook for. Create an organization-level webhook if you provide `*`. | `set(string)` | <pre>[<br>  "*"<br>]</pre> | no |
| <a name="input_secret"></a> [secret](#input\_secret) | (Optional) The shared secret for the webhook. | `string` | `""` | no |
| <a name="input_ssl_enabled"></a> [ssl\_enabled](#input\_ssl\_enabled) | (Optional) Whether to verify SSL certificates when delivering payloads. Default is true. | `bool` | `true` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_content_type"></a> [content\_type](#output\_content\_type) | The content type of the webhook payload. |
| <a name="output_enabled"></a> [enabled](#output\_enabled) | Whether the webhook is enabled. |
| <a name="output_events"></a> [events](#output\_events) | A list of events which trigger the webhook. |
| <a name="output_repositories"></a> [repositories](#output\_repositories) | A list of repositories which the webhook is for. |
| <a name="output_ssl_enabled"></a> [ssl\_enabled](#output\_ssl\_enabled) | Whether SSL verification is enabled. |
| <a name="output_url"></a> [url](#output\_url) | The URL of the webhook. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
