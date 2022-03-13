# org-team

This module creates following resources.

- `github_team`
- `github_team_membership` (optional)

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
| [github_team.this](https://registry.terraform.io/providers/hashicorp/github/4.13.0/docs/resources/team) | resource |
| [github_team_membership.this](https://registry.terraform.io/providers/hashicorp/github/4.13.0/docs/resources/team_membership) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | (Required) The name of the team. | `string` | n/a | yes |
| <a name="input_default_maintainer_enabled"></a> [default\_maintainer\_enabled](#input\_default\_maintainer\_enabled) | (Optional) If true, adds the creating user as a default maintainer to the team. | `bool` | `false` | no |
| <a name="input_description"></a> [description](#input\_description) | (Optional) A description of the team. | `string` | `"Managed by Terraform."` | no |
| <a name="input_is_secret"></a> [is\_secret](#input\_is\_secret) | (Optional) If true, team is only visible to the people on the team and people with owner permissions. | `bool` | `false` | no |
| <a name="input_ldap_group_dn"></a> [ldap\_group\_dn](#input\_ldap\_group\_dn) | (Optional) The LDAP Distinguished Name of the group where membership will be synchronized. Only available in GitHub Enterprise Server. | `string` | `null` | no |
| <a name="input_maintainers"></a> [maintainers](#input\_maintainers) | (Optional) A list of usernames to add users as `maintainer` role. When applied, the user will become a maintainer of the team. | `set(string)` | `[]` | no |
| <a name="input_members"></a> [members](#input\_members) | (Optional) A list of usernames to add users as `member` role. When applied, the user will become a member of the team. | `set(string)` | `[]` | no |
| <a name="input_parent_id"></a> [parent\_id](#input\_parent\_id) | (Optional) The ID of the parent team, if this is a nested team. | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_default_maintainer_enabled"></a> [default\_maintainer\_enabled](#output\_default\_maintainer\_enabled) | Whether to add the creating user as a default maintainer. |
| <a name="output_description"></a> [description](#output\_description) | The description of the team. |
| <a name="output_id"></a> [id](#output\_id) | The ID of the team. |
| <a name="output_is_secret"></a> [is\_secret](#output\_is\_secret) | Whether to be only visible to the people on the team and people with owner permissions. |
| <a name="output_ldap_group_dn"></a> [ldap\_group\_dn](#output\_ldap\_group\_dn) | The LDAP Distinguished Name of the group where membership will be synchronized. |
| <a name="output_maintainers"></a> [maintainers](#output\_maintainers) | A list of the maintainers of the team. |
| <a name="output_members"></a> [members](#output\_members) | A list of the members of the team. |
| <a name="output_name"></a> [name](#output\_name) | The name of the team. |
| <a name="output_node_id"></a> [node\_id](#output\_node\_id) | The Node ID of the team. |
| <a name="output_parent_id"></a> [parent\_id](#output\_parent\_id) | The ID of the parent team. |
| <a name="output_slug"></a> [slug](#output\_slug) | The slug of the team. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
