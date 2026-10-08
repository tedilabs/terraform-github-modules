# enterprise-organization

This module creates following resources.

- `github_membership` (optional)
- `github_organization_block` (optional)

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
| ---- | ------- |
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.12 |
| <a name="requirement_github"></a> [github](#requirement\_github) | >= 6.2 |
| <a name="requirement_telemetry"></a> [telemetry](#requirement\_telemetry) | >= 0.1.1 |

## Providers

| Name | Version |
| ---- | ------- |
| <a name="provider_github"></a> [github](#provider\_github) | >= 6.2 |

## Modules

No modules.

## Resources

| Name | Type |
| ---- | ---- |
| [github_enterprise_organization.this](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/enterprise_organization) | resource |
| [github_enterprise.this](https://registry.terraform.io/providers/integrations/github/latest/docs/data-sources/enterprise) | data source |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_billing_email"></a> [billing\_email](#input\_billing\_email) | (Required) The billing email address. | `string` | n/a | yes |
| <a name="input_enterprise"></a> [enterprise](#input\_enterprise) | (Required) The name (slug) of the enterprise. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | (Required) The name of the organization. | `string` | n/a | yes |
| <a name="input_description"></a> [description](#input\_description) | (Optional) The description of the organization. | `string` | `"Managed by Terraform."` | no |
| <a name="input_display_name"></a> [display\_name](#input\_display\_name) | (Optional) The display name of the organization. If not set, the `name` will be used as the `display_name`. | `string` | `""` | no |
| <a name="input_owners"></a> [owners](#input\_owners) | (Optional) A list of usernames to add users as `owner` role. | `set(string)` | `[]` | no |
| <a name="input_telemetry"></a> [telemetry](#input\_telemetry) | (Optional) A configuration to collect telemetry data for the module. This is used to improve the module and its features. The data collected is anonymous and does not contain any sensitive information. The default configuration enables telemetry collection for machine, network, git, github, github actions, terraform, and toolchain. You can disable telemetry collection by setting `enabled` to `false`. `telemetry` block as defined below.<br/>    (Optional) `enabled` - Whether to enable telemetry collection. Default is `true`.<br/>    (Optional) `capture_machine` - Whether to capture machine information. Default is `true`.<br/>    (Optional) `capture_network` - Whether to capture network information. Default is `true`.<br/>    (Optional) `capture_git` - Whether to capture git information. Default is `true`.<br/>    (Optional) `capture_github` - Whether to capture GitHub information. Default is `true`.<br/>    (Optional) `capture_github_actions` - Whether to capture GitHub Actions information. Default is `true`.<br/>    (Optional) `capture_terraform` - Whether to capture Terraform information. Default is `true`.<br/>    (Optional) `capture_toolchain` - Whether to capture toolchain information. Default is `true`. | <pre>object({<br/>    enabled = optional(bool, true)<br/><br/>    capture_machine        = optional(bool, true)<br/>    capture_network        = optional(bool, true)<br/>    capture_git            = optional(bool, true)<br/>    capture_github         = optional(bool, true)<br/>    capture_github_actions = optional(bool, true)<br/>    capture_terraform      = optional(bool, true)<br/>    capture_toolchain      = optional(bool, true)<br/>  })</pre> | `{}` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_billing_email"></a> [billing\_email](#output\_billing\_email) | The billing email address. |
| <a name="output_database_id"></a> [database\_id](#output\_database\_id) | The database ID of the organization. |
| <a name="output_description"></a> [description](#output\_description) | The description of the organization. |
| <a name="output_display_name"></a> [display\_name](#output\_display\_name) | The display name of the organization. |
| <a name="output_enterprise"></a> [enterprise](#output\_enterprise) | The information of the enterprise which the organization belongs to. |
| <a name="output_id"></a> [id](#output\_id) | The ID of the organization. |
| <a name="output_name"></a> [name](#output\_name) | The name of the organization. |
| <a name="output_owners"></a> [owners](#output\_owners) | A list of organization owner usernames. |
<!-- END_TF_DOCS -->
