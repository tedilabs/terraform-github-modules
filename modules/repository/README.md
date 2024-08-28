# repository

This module creates following resources.

- `github_repository`
- `github_repository_collaborator` (optional)
- `github_repository_collaborators` (optional)
- `github_team_repository` (optional)
- `github_repository_autolink_reference` (optional)
- `github_repository_deploy_key` (optional)
- `github_repository_topics` (optional)
- `github_issue_label` (optional)
- `github_branch_default` (optional)

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.9 |
| <a name="requirement_github"></a> [github](#requirement\_github) | >= 6.2 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_github"></a> [github](#provider\_github) | 6.2.2 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [github_branch.this](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/branch) | resource |
| [github_branch_default.this](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/branch_default) | resource |
| [github_issue_label.this](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/issue_label) | resource |
| [github_repository.this](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository) | resource |
| [github_repository_autolink_reference.this](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository_autolink_reference) | resource |
| [github_repository_collaborator.this](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository_collaborator) | resource |
| [github_repository_collaborators.this](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository_collaborators) | resource |
| [github_repository_deploy_key.this](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository_deploy_key) | resource |
| [github_repository_topics.this](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository_topics) | resource |
| [github_team_repository.this](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/team_repository) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | (Required) A name of the repository. | `string` | n/a | yes |
| <a name="input_access"></a> [access](#input\_access) | (Optional) A configuration for the repository access. `access` block as defined below.<br>    (Optional) `collaborators` - A list of collaborators to the repository. Each item of `collaborators` block as defined below.<br>      (Required) `username` - The GitHub username to add to the repository as a collaborator.<br>      (Optional) `role` - The role to grant the collaborator in the repository. Valid values are `read`, `triage`, `write`, `maintain`, `admin` or the name of an existing custom repository role within the organisation. Default is `write`.<br>    (Optional) `teams` - A list of teams to the repository. Each item of `teams` block as defined below.<br>      (Required) `team` - The GitHub team id or the GitHub team slug.<br>      (Optional) `role` - The role to grant the team in the repository. Valid values are `read`, `triage`, `write`, `maintain`, `admin` or the name of an existing custom repository role within the organisation. Default is `read`.<br>    (Optional) `sync_enabled` - Whether to sync the repository access. Accesses added outside of the Terraform code will be removed. Defaults to `false`. | <pre>object({<br>    collaborators = optional(list(object({<br>      username = string<br>      role     = optional(string, "write")<br>    })), [])<br>    teams = optional(list(object({<br>      team = string<br>      role = optional(string, "read")<br>    })), [])<br>    sync_enabled = optional(bool, false)<br>  })</pre> | `{}` | no |
| <a name="input_archive_on_destroy"></a> [archive\_on\_destroy](#input\_archive\_on\_destroy) | (Optional) Whether to archive the repository instead of deleting on destroy. Defaults to `false`. | `bool` | `false` | no |
| <a name="input_archived"></a> [archived](#input\_archived) | (Optional) Specify if the repository should be archived. Defaults to `false`. NOTE: Currently, the API does not support unarchiving. | `bool` | `false` | no |
| <a name="input_auto_merge_enabled"></a> [auto\_merge\_enabled](#input\_auto\_merge\_enabled) | (Optional) Whether to wait for merge requirements to be met and then merge automatically. Defaults to `false`. | `bool` | `false` | no |
| <a name="input_autolink_references"></a> [autolink\_references](#input\_autolink\_references) | (Optional) A list of autolink references for the repository. Each item of `autolink_references` block as defined below.<br>    (Required) `key_prefix` - This prefix appended by a string will generate a link any time it is found in an issue, pull request, or commit.<br>    (Required) `target_url_template` - The URL must contain <num> for the reference number.<br>    (Optional) `is_alphanumeric` - Whether this autolink reference matches alphanumeric characters. If false, this autolink reference only matches numeric characters. Defaults to `false`. | <pre>set(object({<br>    key_prefix          = string<br>    target_url_template = string<br>    is_alphanumeric     = optional(bool, false)<br>  }))</pre> | `[]` | no |
| <a name="input_branches"></a> [branches](#input\_branches) | (Optional) A list of branches to create and manage within the repository. | `set(string)` | `[]` | no |
| <a name="input_default_branch"></a> [default\_branch](#input\_default\_branch) | (Optional) Set the default branch for the repository. Default is `main` branch. | `string` | `"main"` | no |
| <a name="input_delete_branch_on_merge"></a> [delete\_branch\_on\_merge](#input\_delete\_branch\_on\_merge) | (Optional) Automatically delete head branch after a pull request is merged. Defaults to `true`. | `bool` | `true` | no |
| <a name="input_deploy_keys"></a> [deploy\_keys](#input\_deploy\_keys) | (Optional) A list of deploy keys to grant access to the repository. A deploy key is a SSH key. Each item of `deploy_keys` block as defined below.<br>    (Optional) `name` - A name of deploy key.<br>    (Required) `key` - A SSH key. Begins with 'ssh-rsa', 'ecdsa-sha2-nistp256', 'ecdsa-sha2-nistp384', 'ecdsa-sha2-nistp521', 'ssh-ed25519', 'sk-ecdsa-sha2-nistp256@openssh.com', or 'sk-ssh-ed25519@openssh.com'.<br>    (Optional) `writable` - Whether to allow write access to the repository. The key can be used to push to the repository if enabled. Defaults to `false`. | <pre>list(object({<br>    name     = optional(string)<br>    key      = string<br>    writable = optional(bool, false)<br>  }))</pre> | `[]` | no |
| <a name="input_description"></a> [description](#input\_description) | (Optional) A description of the repository. | `string` | `"Managed by Terraform."` | no |
| <a name="input_features"></a> [features](#input\_features) | (Optional) A list of enabled features on the repository. Available features: `ISSUES`, `PROJECTS`, `WIKI`. Defaults to `["ISSUES"]` | `set(string)` | <pre>[<br>  "ISSUES"<br>]</pre> | no |
| <a name="input_homepage"></a> [homepage](#input\_homepage) | (Optional) A URL of website describing the repository. | `string` | `""` | no |
| <a name="input_is_template"></a> [is\_template](#input\_is\_template) | (Optional) Whether this is a template repository. Defaults to `false`. | `bool` | `false` | no |
| <a name="input_issue_labels"></a> [issue\_labels](#input\_issue\_labels) | (Optional) A list of issue labels for the repository. Each member of `issue_labels` block as defined below.<br>    (Required) `name` - The name of the label.<br>    (Required) `color` - A 6 character hex code, without the leading #, identifying the color of the label.<br>    (Optional) `description` - A short description of the label. | <pre>set(object({<br>    name        = string<br>    color       = string<br>    description = optional(string, "Managed by Terraform.")<br>  }))</pre> | `[]` | no |
| <a name="input_merge_strategies"></a> [merge\_strategies](#input\_merge\_strategies) | (Optional) A list of allowed strategies for merging pull requests on the repository. Available strategies: `MERGE_COMMIT`, `SQUASH`, `REBASE`. Defaults to `["SQUASH", "REBASE"]`. | `set(string)` | <pre>[<br>  "SQUASH",<br>  "REBASE"<br>]</pre> | no |
| <a name="input_pages"></a> [pages](#input\_pages) | (Optional) A configuration of GitHub Pages for the repository. `pages` block as defined below.<br>    (Optional) `enabled` - Whether to enable GitHub Pages for the repository. GitHub Pages is designed to host your personal, organization, or project pages from a GitHub repository. Defaults to `false`.<br>    (Optional) `source` - A configuration of the repository source files for the site. `source` block as defined below.<br>      (Optional) `branch` - The repository branch used to publish the site's source files. Defaults to `gh-pages` branch.<br>      (Optional) `path` - The repository directory path from which the site publishes. Defaults to `/`.<br>    (Optional) `cname` - The custom domain for the repository. This can only be set after the repository has been created. | <pre>object({<br>    enabled = optional(bool, false)<br>    source = optional(object({<br>      branch = optional(string, "gh-pages")<br>      path   = optional(string, "/")<br>    }), {})<br>    cname = optional(string)<br>  })</pre> | `{}` | no |
| <a name="input_template"></a> [template](#input\_template) | (Optional) Use a template repository, license or gitignore to create the repository.this resource. `template` block as defined below.<br>    (Optional) `gitignore` - Choose which files not to track from a list of templates. Use the name of the template without the extension. For example, `Haskell`.<br>    (Optional) `init_readme` - Whether to produce an initial commit with README.md in the repository. Defaults to `false`.<br>    (Optional) `license` - A license tells others what they can and can't do with your code. Use the name of the license template without the extension. For example, `mit` or `mpl-2.0`.<br>    (Optional) `repository` - Start this repository with a template repository's contents. The full name of the repository is required. A string of the form `owner/repository`. | <pre>object({<br>    gitignore   = optional(string)<br>    init_readme = optional(bool, false)<br>    license     = optional(string)<br>    repository  = optional(string)<br>  })</pre> | `{}` | no |
| <a name="input_topics"></a> [topics](#input\_topics) | (Optional) A list of topics for the repository. | `set(string)` | `[]` | no |
| <a name="input_visibility"></a> [visibility](#input\_visibility) | (Optional) Can be `public`, `private` or `internal`. `internal` visibility is only available if your organization is associated with an enterprise account using GitHub Enterprise Cloud or GitHub Enterprise Server 2.20+. | `string` | `"private"` | no |
| <a name="input_vulnerability_alerts"></a> [vulnerability\_alerts](#input\_vulnerability\_alerts) | (Optional) Set to true to enable security alerts for vulnerable dependencies. Enabling requires alerts to be enabled on the owner level. GitHub enables the alerts on public repos but disables them on private repos by default. | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_access"></a> [access](#output\_access) | The configuration for the repository access. |
| <a name="output_archived"></a> [archived](#output\_archived) | Whether the repository is archived. |
| <a name="output_auto_merge_enabled"></a> [auto\_merge\_enabled](#output\_auto\_merge\_enabled) | Whether to wait for merge requirements to be met and then merge automatically. |
| <a name="output_autolink_references"></a> [autolink\_references](#output\_autolink\_references) | A list of autolink references for the repository. |
| <a name="output_branches"></a> [branches](#output\_branches) | A list of the repository branches excluding initial branch. |
| <a name="output_default_branch"></a> [default\_branch](#output\_default\_branch) | The default branch of the repository. |
| <a name="output_delete_branch_on_merge"></a> [delete\_branch\_on\_merge](#output\_delete\_branch\_on\_merge) | Automatically delete head branch after a pull request is merged. |
| <a name="output_deploy_keys"></a> [deploy\_keys](#output\_deploy\_keys) | A map of deploy keys granted access to the repository. |
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
| <a name="output_pages"></a> [pages](#output\_pages) | The repository's GitHub Pages configuration. |
| <a name="output_ssh_clone_url"></a> [ssh\_clone\_url](#output\_ssh\_clone\_url) | The URL that can be provided to `git clone` to clone the repository anonymously via SSH. |
| <a name="output_template"></a> [template](#output\_template) | The template of the repository. |
| <a name="output_topics"></a> [topics](#output\_topics) | A list of topics for the repository. |
| <a name="output_url"></a> [url](#output\_url) | The URL of the repository. |
| <a name="output_visibility"></a> [visibility](#output\_visibility) | The visibility of the repository. Can be `public`, `private` or `internal`. |
| <a name="output_vulnerability_alerts"></a> [vulnerability\_alerts](#output\_vulnerability\_alerts) | Whether the security alerts are enabled for vulnerable dpendencies. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
