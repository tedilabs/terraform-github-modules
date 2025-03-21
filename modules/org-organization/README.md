# org-organization

This module creates following resources.

- `github_membership` (optional)
- `github_organization_block` (optional)
- `github_organization_security_manager` (optional)

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.9 |
| <a name="requirement_github"></a> [github](#requirement\_github) | >= 6.2 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_github"></a> [github](#provider\_github) | 6.2.3 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [github_membership.this](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/membership) | resource |
| [github_organization_block.this](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/organization_block) | resource |
| [github_organization_security_manager.this](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/organization_security_manager) | resource |
| [github_organization.after](https://registry.terraform.io/providers/integrations/github/latest/docs/data-sources/organization) | data source |
| [github_organization.this](https://registry.terraform.io/providers/integrations/github/latest/docs/data-sources/organization) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | (Required) The name of the organization. | `string` | n/a | yes |
| <a name="input_blocked_users"></a> [blocked\_users](#input\_blocked\_users) | (Optional) A list of usernames to block from organization. | `set(string)` | `[]` | no |
| <a name="input_members"></a> [members](#input\_members) | (Optional) A list of usernames to add users as `member` role. When applied, an invitation will be sent to the user to become a member of the organization. | `set(string)` | `[]` | no |
| <a name="input_owners"></a> [owners](#input\_owners) | (Optional) A list of usernames to add users as `admin` role. When applied, an invitation will be sent to the user to become an owner of the organization. | `set(string)` | `[]` | no |
| <a name="input_security_manager_teams"></a> [security\_manager\_teams](#input\_security\_manager\_teams) | (Optional) A list of team slugs to add as security manager teams. Grant a team permission to manage security alerts and settings across the organization. This team will also be granted read access to all repositories. | `set(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_blocked_users"></a> [blocked\_users](#output\_blocked\_users) | A list of blocked usernames from organization. |
| <a name="output_description"></a> [description](#output\_description) | The description of the organization. |
| <a name="output_display_name"></a> [display\_name](#output\_display\_name) | The display name of the organization. |
| <a name="output_id"></a> [id](#output\_id) | The ID of the organization. |
| <a name="output_members"></a> [members](#output\_members) | A list of the members of the organization. |
| <a name="output_name"></a> [name](#output\_name) | The name of the organization. |
| <a name="output_owners"></a> [owners](#output\_owners) | A list of the owners of the organization. |
| <a name="output_plan"></a> [plan](#output\_plan) | The billing plan of the organization. |
| <a name="output_repositories"></a> [repositories](#output\_repositories) | A list of the repositories of the organization. |
| <a name="output_security_manager_teams"></a> [security\_manager\_teams](#output\_security\_manager\_teams) | A list of team slugs to add as security manager teams. |
| <a name="output_users"></a> [users](#output\_users) | A list of all members of the organization. |
<!-- END_TF_DOCS -->
