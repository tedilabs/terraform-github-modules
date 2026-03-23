# repository-environment

This module creates following resources.

- `github_repository_environment`
- `github_repository_environment_deployment_policy` (optional)
- `github_actions_environment_variable` (optional)
- `github_actions_environment_secret` (optional)

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.12 |
| <a name="requirement_github"></a> [github](#requirement\_github) | >= 6.11 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_github"></a> [github](#provider\_github) | 6.11.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [github_repository_environment.this](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository_environment) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | (Required) The name of the environment. | `string` | n/a | yes |
| <a name="input_repository"></a> [repository](#input\_repository) | (Required) The repository name which the environment belongs to. | `string` | n/a | yes |
| <a name="input_allow_admin_to_bypass"></a> [allow\_admin\_to\_bypass](#input\_allow\_admin\_to\_bypass) | (Optional) Whether to allow admins to bypass the wait timer and deployment review. The default value is `true`. | `bool` | `true` | no |
| <a name="input_allows_self_approval"></a> [allows\_self\_approval](#input\_allows\_self\_approval) | (Optional) Whether to allow users to approve their own deployment. The default value is `false`. | `bool` | `false` | no |
| <a name="input_wait_timer"></a> [wait\_timer](#input\_wait\_timer) | (Optional) The amount of time in minutes to wait before allowing deployments to proceed. The default value is `0`. | `number` | `0` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_allow_admin_to_bypass"></a> [allow\_admin\_to\_bypass](#output\_allow\_admin\_to\_bypass) | Whether to allow admins to bypass the wait timer and deployment review. |
| <a name="output_allows_self_approval"></a> [allows\_self\_approval](#output\_allows\_self\_approval) | Whether to allow users to approve their own deployment. |
| <a name="output_name"></a> [name](#output\_name) | The name of the environment. |
| <a name="output_repository"></a> [repository](#output\_repository) | The repository name which the environment belongs to. |
| <a name="output_wait_timer"></a> [wait\_timer](#output\_wait\_timer) | The amount of time in minutes to wait before allowing deployments to proceed. |
<!-- END_TF_DOCS -->
