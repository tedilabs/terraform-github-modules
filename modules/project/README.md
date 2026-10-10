# project

This module creates following resources.

- `github_repository_project` (optional)
- `github_organization_project` (optional)
- `github_project_column` (optional)

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
| ---- | ------- |
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.12 |
| <a name="requirement_github"></a> [github](#requirement\_github) | >= 6.2 |
| <a name="requirement_telemetry"></a> [telemetry](#requirement\_telemetry) | >= 0.2.0 |

## Providers

| Name | Version |
| ---- | ------- |
| <a name="provider_github"></a> [github](#provider\_github) | >= 6.2 |

## Modules

No modules.

## Resources

| Name | Type |
| ---- | ---- |
| [github_organization_project.this](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/organization_project) | resource |
| [github_project_column.this](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/project_column) | resource |
| [github_repository_project.this](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository_project) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_name"></a> [name](#input\_name) | (Required) The name of the project. | `string` | n/a | yes |
| <a name="input_columns"></a> [columns](#input\_columns) | (Optional) A list of columns for the project. | `set(string)` | `[]` | no |
| <a name="input_description"></a> [description](#input\_description) | (Optional) A description of the project. | `string` | `"Managed by Terraform."` | no |
| <a name="input_level"></a> [level](#input\_level) | (Optional) Choose to create a project for organization or repository. Valid values are `ORGANIAZTION` and `REPOSITORY`. The default is `ORGANIZATION` level, so the project is managed by organization level. | `string` | `"ORGANIZATION"` | no |
| <a name="input_repository"></a> [repository](#input\_repository) | (Optional) The repository to create the project for. Only need when `level` is `REPOSITORY`. | `string` | `null` | no |
| <a name="input_telemetry"></a> [telemetry](#input\_telemetry) | (Optional) A configuration to collect telemetry data for the module. This is used to improve the module and its features. To send pseudonyms instead of identifying values such as the hostname and the Git remote, set `pseudonymization_enabled` to `true`. Pseudonyms are not anonymous; to keep data from being sent, disable its collector. The default configuration enables telemetry collection for machine, network, git, github, github actions, HCP Terraform, terraform, and toolchain. You can disable telemetry collection by setting `enabled` to `false`. `telemetry` block as defined below.<br/>    (Optional) `enabled` - Whether to enable telemetry collection. Default is `true`.<br/>    (Optional) `capture_machine` - Whether to capture machine information. Default is `true`.<br/>    (Optional) `capture_network` - Whether to capture network information. Default is `true`.<br/>    (Optional) `capture_git` - Whether to capture git information. Default is `true`.<br/>    (Optional) `capture_github` - Whether to capture GitHub information. Default is `true`.<br/>    (Optional) `capture_github_actions` - Whether to capture GitHub Actions information. Default is `true`.<br/>    (Optional) `capture_hcp_terraform` - Whether to capture HCP Terraform information. Default is `true`.<br/>    (Optional) `capture_terraform` - Whether to capture Terraform information. Default is `true`.<br/>    (Optional) `capture_toolchain` - Whether to capture toolchain information. Default is `true`.<br/>    (Optional) `pseudonymization_enabled` - Whether to enable pseudonymization of the captured data. Default is `false`. | <pre>object({<br/>    enabled = optional(bool, true)<br/><br/>    capture_machine        = optional(bool, true)<br/>    capture_network        = optional(bool, true)<br/>    capture_git            = optional(bool, true)<br/>    capture_github         = optional(bool, true)<br/>    capture_github_actions = optional(bool, true)<br/>    capture_hcp_terraform  = optional(bool, true)<br/>    capture_terraform      = optional(bool, true)<br/>    capture_toolchain      = optional(bool, true)<br/><br/>    pseudonymization_enabled = optional(bool, false)<br/>  })</pre> | `{}` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_columns"></a> [columns](#output\_columns) | A list of columns of the project. |
| <a name="output_description"></a> [description](#output\_description) | The description of the team. |
| <a name="output_id"></a> [id](#output\_id) | The ID of the project. |
| <a name="output_level"></a> [level](#output\_level) | The level of the project. `REPOSITORY` or `ORGANIZATION`. |
| <a name="output_name"></a> [name](#output\_name) | The name of the project. |
| <a name="output_repository"></a> [repository](#output\_repository) | The repository which the project is created. |
| <a name="output_url"></a> [url](#output\_url) | The URL of the project. |
<!-- END_TF_DOCS -->
