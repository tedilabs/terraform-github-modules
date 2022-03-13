# repository

This module creates following resources.

- `github_repository`
- `github_repository_collaborator` (optional)
- `github_team_repository` (optional)
- `github_repository_deploy_key` (optional)
- `github_issue_label` (optional)
- `github_branch_default` (optional)

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
| [github_branch_default.this](https://registry.terraform.io/providers/hashicorp/github/4.13.0/docs/resources/branch_default) | resource |
| [github_issue_label.this](https://registry.terraform.io/providers/hashicorp/github/4.13.0/docs/resources/issue_label) | resource |
| [github_repository.this](https://registry.terraform.io/providers/hashicorp/github/4.13.0/docs/resources/repository) | resource |
| [github_repository_collaborator.this](https://registry.terraform.io/providers/hashicorp/github/4.13.0/docs/resources/repository_collaborator) | resource |
| [github_repository_deploy_key.this](https://registry.terraform.io/providers/hashicorp/github/4.13.0/docs/resources/repository_deploy_key) | resource |
| [github_team_repository.this](https://registry.terraform.io/providers/hashicorp/github/4.13.0/docs/resources/team_repository) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | (Required) A name of the repository. | `string` | n/a | yes |
| <a name="input_admin_collaborators"></a> [admin\_collaborators](#input\_admin\_collaborators) | (Optional) A list of users as collaborator with `admin` permission to the repository. You can use GitHub username. | `set(string)` | `[]` | no |
| <a name="input_admin_teams"></a> [admin\_teams](#input\_admin\_teams) | (Optional) A list of teams with `admin` permission to the repository. You can use GitHub team id or the GitHub team slug. | `set(string)` | `[]` | no |
| <a name="input_archive_on_destroy"></a> [archive\_on\_destroy](#input\_archive\_on\_destroy) | (Optional) Set to `true` to archive the repository instead of deleting on destroy. | `bool` | `false` | no |
| <a name="input_archived"></a> [archived](#input\_archived) | (Optional) Specify if the repository should be archived. Defaults to `false`. NOTE: Currently, the API does not support unarchiving. | `bool` | `false` | no |
| <a name="input_default_branch"></a> [default\_branch](#input\_default\_branch) | (Optional) Set the default branch for the repository. Default is `main` branch. | `string` | `"main"` | no |
| <a name="input_delete_branch_on_merge"></a> [delete\_branch\_on\_merge](#input\_delete\_branch\_on\_merge) | (Optional) Automatically delete head branch after a pull request is merged. Defaults to true. | `bool` | `true` | no |
| <a name="input_deploy_keys"></a> [deploy\_keys](#input\_deploy\_keys) | (Optional) A list of deploy keys to grant access to the repository. A deploy key is a SSH key. Each member of `deploy_keys` block as defined below.<br>    (Required) `name` - A name of deploy key.<br>    (Optional) `key` - A SSH key. Begins with 'ssh-rsa', 'ecdsa-sha2-nistp256', 'ecdsa-sha2-nistp384', 'ecdsa-sha2-nistp521', 'ssh-ed25519', 'sk-ecdsa-sha2-nistp256@openssh.com', or 'sk-ssh-ed25519@openssh.com'.<br>    (Optional) `writable` - Whether to allow write access to the repository. The key can be used to push to the repository if enabled. | <pre>list(object({<br>    name     = string<br>    key      = string<br>    writable = bool<br>  }))</pre> | `[]` | no |
| <a name="input_description"></a> [description](#input\_description) | (Optional) A description of the repository. | `string` | `"Managed by Terraform."` | no |
| <a name="input_features"></a> [features](#input\_features) | (Optional) A list of enabled features on the repository. Available features: `ISSUES`, `PROJECTS`, `WIKI`. | `set(string)` | <pre>[<br>  "ISSUES"<br>]</pre> | no |
| <a name="input_homepage"></a> [homepage](#input\_homepage) | (Optional) A URL of website describing the repository. | `string` | `null` | no |
| <a name="input_is_template"></a> [is\_template](#input\_is\_template) | (Optional) Set to `true` if this is a template repository. | `bool` | `false` | no |
| <a name="input_issue_labels"></a> [issue\_labels](#input\_issue\_labels) | (Optional) A list of issue labels for the repository. Each member of `issue_labels` block as defined below.<br>    (Required) `name` - The name of the label.<br>    (Required) `color` - A 6 character hex code, without the leading #, identifying the color of the label.<br>    (Optional) `description` - A short description of the label. | `set(map(string))` | `[]` | no |
| <a name="input_maintain_collaborators"></a> [maintain\_collaborators](#input\_maintain\_collaborators) | (Optional) A list of users as collaborator with `maintain` permission to the repository. You can use GitHub username. | `set(string)` | `[]` | no |
| <a name="input_maintain_teams"></a> [maintain\_teams](#input\_maintain\_teams) | (Optional) A list of teams with `maintain` permission to the repository. You can use GitHub team id or the GitHub team slug. | `set(string)` | `[]` | no |
| <a name="input_merge_strategies"></a> [merge\_strategies](#input\_merge\_strategies) | (Optional) A list of allowed strategies for merging pull requests on the repository. Available strategies: `MERGE_COMMIT`, `SQUASH`, `REBASE`. | `set(string)` | <pre>[<br>  "SQUASH",<br>  "REBASE"<br>]</pre> | no |
| <a name="input_read_collaborators"></a> [read\_collaborators](#input\_read\_collaborators) | (Optional) A list of users as collaborator with `read` permission to the repository. You can use GitHub username. | `set(string)` | `[]` | no |
| <a name="input_read_teams"></a> [read\_teams](#input\_read\_teams) | (Optional) A list of teams with `read` permission to the repository. You can use GitHub team id or the GitHub team slug. | `set(string)` | `[]` | no |
| <a name="input_template"></a> [template](#input\_template) | (Optional) Use a template repository, license or gitignore to create the repository.this resource. `template` block as defined below.<br>    (Optional) `gitignore` - Choose which files not to track from a list of templates. Use the name of the template without the extension. For example, `Haskell`.<br>    (Optional) `init_readme` - Set to `true` to produce an initial commit with README.md in the repository.<br>    (Optional) `license` - A license tells others what they can and can't do with your code. Use the name of the license template without the extension. For example, `mit` or `mpl-2.0`.<br>    (Optional) `repository` - Start this repository with a template repository's contents. The full name of the repository is required. A string of the form `owner/repository`. | `any` | `{}` | no |
| <a name="input_topics"></a> [topics](#input\_topics) | (Optional) A list of topics for the repository. | `set(string)` | `[]` | no |
| <a name="input_triage_collaborators"></a> [triage\_collaborators](#input\_triage\_collaborators) | (Optional) A list of users as collaborator with `triage` permission to the repository. You can use GitHub username. | `set(string)` | `[]` | no |
| <a name="input_triage_teams"></a> [triage\_teams](#input\_triage\_teams) | (Optional) A list of teams with `triage` permission to the repository. You can use GitHub team id or the GitHub team slug. | `set(string)` | `[]` | no |
| <a name="input_visibility"></a> [visibility](#input\_visibility) | (Optional) Can be `public`, `private` or `internal`. `internal` visibility is only available if your organization is associated with an enterprise account using GitHub Enterprise Cloud or GitHub Enterprise Server 2.20+. | `string` | `"private"` | no |
| <a name="input_write_collaborators"></a> [write\_collaborators](#input\_write\_collaborators) | (Optional) A list of users as collaborator with `write` permission to the repository. You can use GitHub username. | `set(string)` | `[]` | no |
| <a name="input_write_teams"></a> [write\_teams](#input\_write\_teams) | (Optional) A list of teams with `write` permission to the repository. You can use GitHub team id or the GitHub team slug. | `set(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_archived"></a> [archived](#output\_archived) | Whether the repository is archived. |
| <a name="output_default_branch"></a> [default\_branch](#output\_default\_branch) | The default branch of the repository. |
| <a name="output_delete_branch_on_merge"></a> [delete\_branch\_on\_merge](#output\_delete\_branch\_on\_merge) | Automatically delete head branch after a pull request is merged. |
| <a name="output_deploy_keys"></a> [deploy\_keys](#output\_deploy\_keys) | A list of deploy keys granted access to the repository. |
| <a name="output_description"></a> [description](#output\_description) | The description of the repository. |
| <a name="output_features"></a> [features](#output\_features) | A list of available features on the repository. |
| <a name="output_full_name"></a> [full\_name](#output\_full\_name) | The full name of the repository. A string of the form `orgname/reponame` |
| <a name="output_git_clone_url"></a> [git\_clone\_url](#output\_git\_clone\_url) | The URL that can be provided to `git clone` to clone the repository anonymously via the git protocol. |
| <a name="output_homepage"></a> [homepage](#output\_homepage) | A URL of the website for the repository. |
| <a name="output_http_clone_url"></a> [http\_clone\_url](#output\_http\_clone\_url) | The URL that can be provided to `git clone` to clone the repository anonymously via HTTPS. |
| <a name="output_id"></a> [id](#output\_id) | The ID of the GitHub repository. |
| <a name="output_is_template"></a> [is\_template](#output\_is\_template) | Whether this is a template repository. |
| <a name="output_issue_labels"></a> [issue\_labels](#output\_issue\_labels) | A list of issue labels for the repository. |
| <a name="output_merge_strategies"></a> [merge\_strategies](#output\_merge\_strategies) | A list of available strategies for merging pull requests on the repository. |
| <a name="output_name"></a> [name](#output\_name) | The name of the repository. |
| <a name="output_node_id"></a> [node\_id](#output\_node\_id) | The node ID of the GitHub repository. This is GraphQL global node id for use with v4 API. |
| <a name="output_permissions"></a> [permissions](#output\_permissions) | The access control list which manage individual and team access to the repository. |
| <a name="output_ssh_clone_url"></a> [ssh\_clone\_url](#output\_ssh\_clone\_url) | The URL that can be provided to `git clone` to clone the repository anonymously via SSH. |
| <a name="output_template"></a> [template](#output\_template) | The template of the repository. |
| <a name="output_topics"></a> [topics](#output\_topics) | A list of topics for the repository. |
| <a name="output_url"></a> [url](#output\_url) | The URL of the repository. |
| <a name="output_visibility"></a> [visibility](#output\_visibility) | The visibility of the repository. Can be `public`, `private` or `internal`. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
