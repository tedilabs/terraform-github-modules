variable "name" {
  description = "(Required) A name of the repository."
  type        = string
  nullable    = false
}

variable "description" {
  description = "(Optional) A description of the repository."
  type        = string
  default     = "Managed by Terraform."
  nullable    = false
}

variable "homepage" {
  description = "(Optional) A URL of website describing the repository."
  type        = string
  default     = null
}

variable "visibility" {
  description = "(Optional) Can be `public`, `private` or `internal`. `internal` visibility is only available if your organization is associated with an enterprise account using GitHub Enterprise Cloud or GitHub Enterprise Server 2.20+."
  type        = string
  default     = "private"
  nullable    = false
}

variable "is_template" {
  description = "(Optional) Set to `true` if this is a template repository."
  type        = bool
  default     = false
  nullable    = false
}

variable "archived" {
  description = "(Optional) Specify if the repository should be archived. Defaults to `false`. NOTE: Currently, the API does not support unarchiving."
  type        = bool
  default     = false
  nullable    = false
}

variable "archive_on_destroy" {
  description = "(Optional) Set to `true` to archive the repository instead of deleting on destroy."
  type        = bool
  default     = false
  nullable    = false
}

# INFO: https://github.com/github/gitignore
# INFO: https://github.com/github/choosealicense.com/tree/gh-pages/_licenses
variable "template" {
  description = <<EOF
  (Optional) Use a template repository, license or gitignore to create the repository.this resource. `template` block as defined below.
    (Optional) `gitignore` - Choose which files not to track from a list of templates. Use the name of the template without the extension. For example, `Haskell`.
    (Optional) `init_readme` - Set to `true` to produce an initial commit with README.md in the repository.
    (Optional) `license` - A license tells others what they can and can't do with your code. Use the name of the license template without the extension. For example, `mit` or `mpl-2.0`.
    (Optional) `repository` - Start this repository with a template repository's contents. The full name of the repository is required. A string of the form `owner/repository`.
  EOF
  type        = any
  default     = {}
  nullable    = false
}

variable "features" {
  description = "(Optional) A list of enabled features on the repository. Available features: `ISSUES`, `PROJECTS`, `WIKI`."
  type        = set(string)
  default     = ["ISSUES"]
  nullable    = false

  validation {
    condition = alltrue([
      for feature in var.features :
      contains(["ISSUES", "PROJECTS", "WIKI"], feature)
    ])
    error_message = "Available features: `ISSUES`, `PROJECTS`, `WIKI`."
  }
}

variable "merge_strategies" {
  description = "(Optional) A list of allowed strategies for merging pull requests on the repository. Available strategies: `MERGE_COMMIT`, `SQUASH`, `REBASE`."
  type        = set(string)
  default     = ["SQUASH", "REBASE"]
  nullable    = false

  validation {
    condition = alltrue([
      for strategy in var.merge_strategies :
      contains(["MERGE_COMMIT", "SQUASH", "REBASE"], strategy)
    ])
    error_message = "Available strategies: `MERGE_COMMIT`, `SQUASH`, `REBASE`."
  }
}

variable "delete_branch_on_merge" {
  description = "(Optional) Automatically delete head branch after a pull request is merged. Defaults to `true`."
  type        = bool
  default     = true
  nullable    = false
}

variable "topics" {
  description = "(Optional) A list of topics for the repository."
  type        = set(string)
  default     = []
  nullable    = false
}

variable "issue_labels" {
  description = <<EOF
  (Optional) A list of issue labels for the repository. Each member of `issue_labels` block as defined below.
    (Required) `name` - The name of the label.
    (Required) `color` - A 6 character hex code, without the leading #, identifying the color of the label.
    (Optional) `description` - A short description of the label.
  EOF
  type = set(object({
    name        = string
    color       = string
    description = optional(string, "Managed by Terraform.")
  }))
  default  = []
  nullable = false
}

variable "autolink_references" {
  description = <<EOF
  (Optional) A list of autolink references for the repository. Each item of `autolink_references` block as defined below.
    (Required) `key_prefix` - This prefix appended by a string will generate a link any time it is found in an issue, pull request, or commit.
    (Required) `target_url_template` - The URL must contain <num> for the reference number.
    (Optional) `is_alphanumeric` - Whether this autolink reference matches alphanumeric characters. If false, this autolink reference only matches numeric characters. Defaults to `false`.
  EOF
  type = set(object({
    key_prefix          = string
    target_url_template = string
    is_alphanumeric     = optional(bool, false)
  }))
  default  = []
  nullable = false
}

variable "access" {
  description = <<EOF
  (Optional) A configuration for the repository access. `access` block as defined below.
    (Optional) `collaborators` - A list of collaborators to the repository. Each item of `collaborators` block as defined below.
      (Required) `username` - The GitHub username to add to the repository as a collaborator.
      (Optional) `role` - The role to grant the collaborator in the repository. Valid values are `read`, `triage`, `write`, `maintain`, `admin` or the name of an existing custom repository role within the organisation. Default is `write`.
    (Optional) `teams` - A list of teams to the repository. Each item of `teams` block as defined below.
      (Required) `team` - The GitHub team id or the GitHub team slug.
      (Optional) `role` - The role to grant the team in the repository. Valid values are `read`, `triage`, `write`, `maintain`, `admin` or the name of an existing custom repository role within the organisation. Default is `read`.
    (Optional) `sync_enabled` - Whether to sync the repository access. Accesses added outside of the Terraform code will be removed. Defaults to `false`.
  EOF
  type = object({
    collaborators = optional(list(object({
      username = string
      role     = optional(string, "write")
    })), [])
    teams = optional(list(object({
      team = string
      role = optional(string, "read")
    })), [])
    sync_enabled = optional(bool, false)
  })
  default  = {}
  nullable = false
}

variable "branches" {
  description = "(Optional) A list of branches to create and manage within the repository."
  type        = set(string)
  default     = []
  nullable    = false
}

variable "default_branch" {
  description = "(Optional) Set the default branch for the repository. Default is `main` branch."
  type        = string
  default     = "main"
}

variable "vulnerability_alerts" {
  description = "(Optional) Set to true to enable security alerts for vulnerable dependencies. Enabling requires alerts to be enabled on the owner level. GitHub enables the alerts on public repos but disables them on private repos by default."
  type        = bool
  default     = false
  nullable    = false
}

variable "deploy_keys" {
  description = <<EOF
  (Optional) A list of deploy keys to grant access to the repository. A deploy key is a SSH key. Each item of `deploy_keys` block as defined below.
    (Optional) `name` - A name of deploy key.
    (Required) `key` - A SSH key. Begins with 'ssh-rsa', 'ecdsa-sha2-nistp256', 'ecdsa-sha2-nistp384', 'ecdsa-sha2-nistp521', 'ssh-ed25519', 'sk-ecdsa-sha2-nistp256@openssh.com', or 'sk-ssh-ed25519@openssh.com'.
    (Optional) `writable` - Whether to allow write access to the repository. The key can be used to push to the repository if enabled. Defaults to `false`.
  EOF
  type = list(object({
    name     = optional(string)
    key      = string
    writable = optional(bool, false)
  }))
  default  = []
  nullable = false
}

variable "pages_enabled" {
  description = "(Optional) Set to true to enable GitHub Pages for the repository. GitHub Pages is designed to host your personal, organization, or project pages from a GitHub repository."
  type        = bool
  default     = false
  nullable    = false
}

variable "pages_source_branch" {
  description = "(Optional) The repository branch used to publish the site's source files. Defaults to `gh-pages` branch."
  type        = string
  default     = "gh-pages"
  nullable    = false
}

variable "pages_source_path" {
  description = "(Optional) The repository directory path from which the site publishes. Defaults to `/`."
  type        = string
  default     = "/"
  nullable    = false
}

variable "pages_cname" {
  description = "(Optional) The custom domain for the repository. This can only be set after the repository has been created."
  type        = string
  default     = null
  nullable    = true
}
