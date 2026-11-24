# repository-ruleset

This module creates following resources.

- `github_repository_ruleset`

## Automatic Copilot code review

This module currently supports branch rulesets with the Copilot code review rule. Manage existing repositories by name, independently of the `repository` module. Use `for_each` at the call site to target multiple repositories.

- Omit `copilot_code_review` or set it to `null` to omit the rule from this ruleset.
- Set it to `{}` to request reviews when a pull request is opened or first marked ready for review.
- Set `review_on_push = true` to review subsequent pushes.
- Set `review_draft_pull_requests = true` to include draft pull requests.

The rule does not require `pull_request` merge restrictions. Omitting it does not disable reviews enabled by another ruleset or personal settings.

Repository rulesets are available for public repositories on GitHub Free. Private repositories require GitHub Pro for personal repositories or GitHub Team/Enterprise for organization repositories. The caller needs permission to manage rulesets. Copilot access and usage limits are separate prerequisites; this module does not grant licenses or configure billing.

See the [example](../../examples/repository-ruleset-copilot), [GitHub ruleset availability](https://docs.github.com/en/repositories/configuring-branches-and-merges-in-your-repository/managing-rulesets/about-rulesets), and [Copilot review configuration](https://docs.github.com/en/copilot/how-tos/copilot-on-github/set-up-copilot/configure-code-review).

## Tests

Run `terraform init` followed by `terraform test` in this module directory. Tests use a mocked GitHub provider, disable telemetry, and only run plans; they do not change GitHub resources.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
| ---- | ------- |
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.16 |
| <a name="requirement_github"></a> [github](#requirement\_github) | >= 6.11 |
| <a name="requirement_telemetry"></a> [telemetry](#requirement\_telemetry) | >= 0.2.0 |

## Providers

| Name | Version |
| ---- | ------- |
| <a name="provider_github"></a> [github](#provider\_github) | >= 6.11 |

## Modules

No modules.

## Resources

| Name | Type |
| ---- | ---- |
| [github_repository_ruleset.this](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository_ruleset) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_name"></a> [name](#input\_name) | (Required) The name of the repository ruleset. | `string` | n/a | yes |
| <a name="input_repository"></a> [repository](#input\_repository) | (Required) The repository name which the ruleset belongs to. The owner is configured through the GitHub provider. | `string` | n/a | yes |
| <a name="input_conditions"></a> [conditions](#input\_conditions) | (Optional) A configuration for the conditions that determine which refs the ruleset applies to. `conditions` block as defined below.<br/>    (Optional) `ref_name` - A configuration for matching branches. `ref_name` block as defined below.<br/>      (Optional) `include` - A list of ref names or patterns to include. Also accepts `~ALL` and `~DEFAULT_BRANCH`. Defaults to `["~DEFAULT_BRANCH"]`.<br/>      (Optional) `exclude` - A list of ref names or patterns to exclude. Defaults to `[]`. | <pre>object({<br/>    ref_name = optional(object({<br/>      include = optional(list(string), ["~DEFAULT_BRANCH"])<br/>      exclude = optional(list(string), [])<br/>    }), {})<br/>  })</pre> | `{}` | no |
| <a name="input_rules"></a> [rules](#input\_rules) | (Optional) A configuration for the rules enforced by the ruleset. Currently only Copilot code review is supported. `rules` block as defined below.<br/>    (Optional) `copilot_code_review` - A configuration to automatically request Copilot code reviews. Only valid when `target` is `branch`. Omit or set to `null` to omit this rule; set to `{}` to enable reviews with the default options. `copilot_code_review` block as defined below.<br/>      (Optional) `review_on_push` - Whether to review each new push to a pull request. Defaults to `false`.<br/>      (Optional) `review_draft_pull_requests` - Whether to review draft pull requests before they are ready for review. Defaults to `false`. | <pre>object({<br/>    copilot_code_review = optional(object({<br/>      review_on_push             = optional(bool, false)<br/>      review_draft_pull_requests = optional(bool, false)<br/>    }))<br/>  })</pre> | `{}` | no |
| <a name="input_status"></a> [status](#input\_status) | (Optional) The status (enforcement level) of the ruleset. Can be one of `ACTIVE` or `DISABLED`. Defaults to `ACTIVE`. | `string` | `"ACTIVE"` | no |
| <a name="input_target"></a> [target](#input\_target) | (Optional) The target of the ruleset. Currently only `branch` is supported. Defaults to `branch`. | `string` | `"branch"` | no |
| <a name="input_telemetry"></a> [telemetry](#input\_telemetry) | (Optional) A configuration to collect telemetry data for the module. This is used to improve the module and its features. To send pseudonyms instead of identifying values such as the hostname and the Git remote, set `pseudonymization_enabled` to `true`. Pseudonyms are not anonymous; to keep data from being sent, disable its collector. The default configuration enables telemetry collection for machine, network, git, github, github actions, HCP Terraform, terraform, and toolchain. You can disable telemetry collection by setting `enabled` to `false`. `telemetry` block as defined below.<br/>    (Optional) `enabled` - Whether to enable telemetry collection. Default is `true`.<br/>    (Optional) `capture_machine` - Whether to capture machine information. Default is `true`.<br/>    (Optional) `capture_network` - Whether to capture network information. Default is `true`.<br/>    (Optional) `capture_git` - Whether to capture git information. Default is `true`.<br/>    (Optional) `capture_github` - Whether to capture GitHub information. Default is `true`.<br/>    (Optional) `capture_github_actions` - Whether to capture GitHub Actions information. Default is `true`.<br/>    (Optional) `capture_hcp_terraform` - Whether to capture HCP Terraform information. Default is `true`.<br/>    (Optional) `capture_terraform` - Whether to capture Terraform information. Default is `true`.<br/>    (Optional) `capture_toolchain` - Whether to capture toolchain information. Default is `true`.<br/>    (Optional) `pseudonymization_enabled` - Whether to enable pseudonymization of the captured data. Default is `false`. | <pre>object({<br/>    enabled = optional(bool, true)<br/><br/>    capture_machine        = optional(bool, true)<br/>    capture_network        = optional(bool, true)<br/>    capture_git            = optional(bool, true)<br/>    capture_github         = optional(bool, true)<br/>    capture_github_actions = optional(bool, true)<br/>    capture_hcp_terraform  = optional(bool, true)<br/>    capture_terraform      = optional(bool, true)<br/>    capture_toolchain      = optional(bool, true)<br/><br/>    pseudonymization_enabled = optional(bool, false)<br/>  })</pre> | `{}` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_conditions"></a> [conditions](#output\_conditions) | The conditions that determine which refs the ruleset applies to. |
| <a name="output_id"></a> [id](#output\_id) | The ID of the repository ruleset. |
| <a name="output_name"></a> [name](#output\_name) | The name of the repository ruleset. |
| <a name="output_node_id"></a> [node\_id](#output\_node\_id) | The node ID of the repository ruleset. |
| <a name="output_repository"></a> [repository](#output\_repository) | The repository name which the ruleset belongs to. |
| <a name="output_rules"></a> [rules](#output\_rules) | The rules enforced by the ruleset. |
| <a name="output_ruleset_id"></a> [ruleset\_id](#output\_ruleset\_id) | The GitHub-assigned numeric ID of the repository ruleset. |
| <a name="output_status"></a> [status](#output\_status) | The status (enforcement level) of the repository ruleset. |
| <a name="output_target"></a> [target](#output\_target) | The target of the repository ruleset. |
<!-- END_TF_DOCS -->
