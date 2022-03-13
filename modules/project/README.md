# project

This module creates following resources.

- `github_repository_project` (optional)
- `github_organization_project` (optional)
- `github_project_column` (optional)

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
| [github_organization_project.this](https://registry.terraform.io/providers/hashicorp/github/4.13.0/docs/resources/organization_project) | resource |
| [github_project_column.this](https://registry.terraform.io/providers/hashicorp/github/4.13.0/docs/resources/project_column) | resource |
| [github_repository_project.this](https://registry.terraform.io/providers/hashicorp/github/4.13.0/docs/resources/repository_project) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | (Required) The name of the project. | `string` | n/a | yes |
| <a name="input_columns"></a> [columns](#input\_columns) | (Optional) A list of columns for the project. | `set(string)` | `[]` | no |
| <a name="input_description"></a> [description](#input\_description) | (Optional) A description of the project. | `string` | `"Managed by Terraform."` | no |
| <a name="input_level"></a> [level](#input\_level) | (Optional) Choose to create a project for organization or repository. Valid values are `ORGANIAZTION` and `REPOSITORY`. The default is `ORGANIZATION` level, so the project is managed by organization level. | `string` | `"ORGANIZATION"` | no |
| <a name="input_repository"></a> [repository](#input\_repository) | (Optional) The repository to create the project for. Only need when `level` is `REPOSITORY`. | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_columns"></a> [columns](#output\_columns) | A list of columns of the project. |
| <a name="output_description"></a> [description](#output\_description) | The description of the team. |
| <a name="output_id"></a> [id](#output\_id) | The ID of the project. |
| <a name="output_level"></a> [level](#output\_level) | The level of the project. `REPOSITORY` or `ORGANIZATION`. |
| <a name="output_name"></a> [name](#output\_name) | The name of the project. |
| <a name="output_repository"></a> [repository](#output\_repository) | The repository which the project is created. |
| <a name="output_url"></a> [url](#output\_url) | The URL of the project. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
