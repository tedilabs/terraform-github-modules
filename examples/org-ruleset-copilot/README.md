# org-ruleset-copilot

Automatically review pull requests to the default branch of selected repositories.

Set `owner` and `repositories` and authenticate the GitHub provider before running Terraform. Applying this example enables reviews and can consume Copilot usage. Organization rulesets require GitHub Team or Enterprise and organization-level administration permissions.

```hcl
owner        = "your-organization"
repositories = ["example-repository"]
```

The example enables re-reviews on new pushes and leaves draft reviews disabled. Review eligibility depends on the author’s Copilot access and the applicable organization policy and usage limits.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
| ---- | ------- |
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.16 |
| <a name="requirement_github"></a> [github](#requirement\_github) | >= 6.11 |

## Providers

No providers.

## Modules

| Name | Source | Version |
| ---- | ------ | ------- |
| <a name="module_copilot_review"></a> [copilot\_review](#module\_copilot\_review) | ../../modules/org-ruleset | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_owner"></a> [owner](#input\_owner) | (Required) The GitHub organization that owns the repositories. | `string` | n/a | yes |
| <a name="input_repositories"></a> [repositories](#input\_repositories) | (Required) The names of the repositories to automatically review. | `set(string)` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->
