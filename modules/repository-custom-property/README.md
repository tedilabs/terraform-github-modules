# repository-custom-property

This module creates following resources.

- `github_organization_custom_properties`

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
| ---- | ------- |
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.12 |
| <a name="requirement_github"></a> [github](#requirement\_github) | >= 6.11 |
| <a name="requirement_telemetry"></a> [telemetry](#requirement\_telemetry) | >= 0.1.1 |

## Providers

| Name | Version |
| ---- | ------- |
| <a name="provider_github"></a> [github](#provider\_github) | >= 6.11 |

## Modules

No modules.

## Resources

| Name | Type |
| ---- | ---- |
| [github_organization_custom_properties.this](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/organization_custom_properties) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_name"></a> [name](#input\_name) | (Required) The name of the custom property. | `string` | n/a | yes |
| <a name="input_allowed_values"></a> [allowed\_values](#input\_allowed\_values) | (Optional) A set of allowed values for the custom property. This is required if the `type` is `SINGLE_SELECT` or `MULTI_SELECT`. | `set(string)` | `[]` | no |
| <a name="input_default"></a> [default](#input\_default) | (Optional) The default value of the custom property. | `any` | `null` | no |
| <a name="input_description"></a> [description](#input\_description) | (Optional) The description of the custom property. | `string` | `""` | no |
| <a name="input_editable_by"></a> [editable\_by](#input\_editable\_by) | (Optional) Who can edit the values of the custom property. Can be one of `ORG_ACTORS` or `ORG_AND_REPO_ACTORS`. When set to `ORG_ACTORS` (the default), only organization owners can edit the property values on repositories. When set to `ORG_AND_REPO_ACTORS`, both organization owners and repository administrators with the custom properties permission can edit the values. | `string` | `"ORG_ACTORS"` | no |
| <a name="input_required"></a> [required](#input\_required) | (Optional) Whether the custom property is required. Defaults to `false`. | `bool` | `false` | no |
| <a name="input_telemetry"></a> [telemetry](#input\_telemetry) | (Optional) A configuration to collect telemetry data for the module. This is used to improve the module and its features. The data collected is anonymous and does not contain any sensitive information. The default configuration enables telemetry collection for machine, network, git, github, github actions, terraform, and toolchain. You can disable telemetry collection by setting `enabled` to `false`. `telemetry` block as defined below.<br/>    (Optional) `enabled` - Whether to enable telemetry collection. Default is `true`.<br/>    (Optional) `capture_machine` - Whether to capture machine information. Default is `true`.<br/>    (Optional) `capture_network` - Whether to capture network information. Default is `true`.<br/>    (Optional) `capture_git` - Whether to capture git information. Default is `true`.<br/>    (Optional) `capture_github` - Whether to capture GitHub information. Default is `true`.<br/>    (Optional) `capture_github_actions` - Whether to capture GitHub Actions information. Default is `true`.<br/>    (Optional) `capture_terraform` - Whether to capture Terraform information. Default is `true`.<br/>    (Optional) `capture_toolchain` - Whether to capture toolchain information. Default is `true`. | <pre>object({<br/>    enabled = optional(bool, true)<br/><br/>    capture_machine        = optional(bool, true)<br/>    capture_network        = optional(bool, true)<br/>    capture_git            = optional(bool, true)<br/>    capture_github         = optional(bool, true)<br/>    capture_github_actions = optional(bool, true)<br/>    capture_terraform      = optional(bool, true)<br/>    capture_toolchain      = optional(bool, true)<br/>  })</pre> | `{}` | no |
| <a name="input_type"></a> [type](#input\_type) | (Required) The type of the custom property. Can be one of `STRING`, `SINGLE_SELECT`, `MULTI_SELECT`, or `BOOL`. Defaults to `STRING`. | `string` | `"STRING"` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_allowed_values"></a> [allowed\_values](#output\_allowed\_values) | A set of allowed values for the custom property. |
| <a name="output_default"></a> [default](#output\_default) | The default value of the custom property. |
| <a name="output_description"></a> [description](#output\_description) | The description of the custom property. |
| <a name="output_editable_by"></a> [editable\_by](#output\_editable\_by) | The configuration for deployment policy of the environment. |
| <a name="output_id"></a> [id](#output\_id) | The ID of the custom property. |
| <a name="output_name"></a> [name](#output\_name) | The name of the custom property. |
| <a name="output_required"></a> [required](#output\_required) | Whether the custom property is required. |
| <a name="output_type"></a> [type](#output\_type) | The type of the custom property. |
<!-- END_TF_DOCS -->
