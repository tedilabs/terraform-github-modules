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
| [github_actions_environment_secret.this](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/actions_environment_secret) | resource |
| [github_actions_environment_variable.this](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/actions_environment_variable) | resource |
| [github_repository_environment.this](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository_environment) | resource |
| [github_repository_environment_deployment_policy.branch](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository_environment_deployment_policy) | resource |
| [github_repository_environment_deployment_policy.tag](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository_environment_deployment_policy) | resource |
| [github_team.this](https://registry.terraform.io/providers/integrations/github/latest/docs/data-sources/team) | data source |
| [github_user.this](https://registry.terraform.io/providers/integrations/github/latest/docs/data-sources/user) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | (Required) The name of the environment. | `string` | n/a | yes |
| <a name="input_repository"></a> [repository](#input\_repository) | (Required) The repository name which the environment belongs to. | `string` | n/a | yes |
| <a name="input_allow_admin_to_bypass"></a> [allow\_admin\_to\_bypass](#input\_allow\_admin\_to\_bypass) | (Optional) Whether to allow admins to bypass the wait timer and deployment review. The default value is `true`. | `bool` | `true` | no |
| <a name="input_allow_self_approval"></a> [allow\_self\_approval](#input\_allow\_self\_approval) | (Optional) Whether to allow users to approve their own deployment. The default value is `false`. | `bool` | `false` | no |
| <a name="input_deployment_policy"></a> [deployment\_policy](#input\_deployment\_policy) | (Optional) A configuration for deployment policy. `deployment_policy` block as defined below.<br/>    (Optional) `restriction` - The type of deployment restriction. Valid values are `NONE`, `PROTECTED_BRANCH`, or `CUSTOM`. Defaults to `NONE`.<br/>    (Optional) `branches` - A set of branch name patterns to restrict deployments to when the restriction type is `CUSTOM`.<br/>    (Optional) `tags` - A set of tag name patterns to restrict deployments to when the restriction type is `CUSTOM`. | <pre>object({<br/>    restriction = optional(string, "NONE")<br/>    branches    = optional(set(string), [])<br/>    tags        = optional(set(string), [])<br/>  })</pre> | `{}` | no |
| <a name="input_reviewers"></a> [reviewers](#input\_reviewers) | (Optional) A list of reviewers who may review jobs that reference the environment. Up to 6 reviewers can be added to an environment. Each item of `reviewers` block as defined below.<br/>    (Required) `type` - The type of the reviewer. Valid values are `USER` or `TEAM`.<br/>    (Required) `name` - The username of the reviewer if the type is `USER`, or the team slug if the type is `TEAM`. | <pre>list(object({<br/>    type = string<br/>    name = string<br/>  }))</pre> | `[]` | no |
| <a name="input_secrets"></a> [secrets](#input\_secrets) | (Optional) A map of GitHub Actions secrets to set for the environment. Currently, all values will be ignored and treated as placeholders. You should mange the secrets manually in GitHub after the environment is created. Defaults to `{}`. | `map(string)` | `{}` | no |
| <a name="input_variables"></a> [variables](#input\_variables) | (Optional) A map of GitHub Actions variables to set for the environment. Defaults to `{}`. | `map(string)` | `{}` | no |
| <a name="input_wait_timer"></a> [wait\_timer](#input\_wait\_timer) | (Optional) The amount of time in minutes to wait before allowing deployments to proceed. The default value is `0`. | `number` | `0` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_allow_admin_to_bypass"></a> [allow\_admin\_to\_bypass](#output\_allow\_admin\_to\_bypass) | Whether to allow admins to bypass the wait timer and deployment review. |
| <a name="output_allow_self_approval"></a> [allow\_self\_approval](#output\_allow\_self\_approval) | Whether to allow users to approve their own deployment. |
| <a name="output_deployment_policy"></a> [deployment\_policy](#output\_deployment\_policy) | The configuration for deployment policy of the environment. |
| <a name="output_name"></a> [name](#output\_name) | The name of the environment. |
| <a name="output_repository"></a> [repository](#output\_repository) | The repository name which the environment belongs to. |
| <a name="output_reviewers"></a> [reviewers](#output\_reviewers) | A list of reviewers who may review jobs that reference the environment. |
| <a name="output_secrets"></a> [secrets](#output\_secrets) | A map of GitHub Actions secrets set for the environment. Currently, all values will be placeholders and you should manage the secrets manually in GitHub after the environment is created. |
| <a name="output_variables"></a> [variables](#output\_variables) | A map of GitHub Actions variables set for the environment. |
| <a name="output_wait_timer"></a> [wait\_timer](#output\_wait\_timer) | The amount of time in minutes to wait before allowing deployments to proceed. |
<!-- END_TF_DOCS -->
