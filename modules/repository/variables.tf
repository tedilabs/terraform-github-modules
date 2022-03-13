variable "name" {
  description = "(Required) A name of the repository."
  type        = string
}

variable "description" {
  description = "(Optional) A description of the repository."
  type        = string
  default     = "Managed by Terraform."
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
}

variable "is_template" {
  description = "(Optional) Set to `true` if this is a template repository."
  type        = bool
  default     = false
}

variable "archived" {
  description = "(Optional) Specify if the repository should be archived. Defaults to `false`. NOTE: Currently, the API does not support unarchiving."
  type        = bool
  default     = false
}

variable "archive_on_destroy" {
  description = "(Optional) Set to `true` to archive the repository instead of deleting on destroy."
  type        = bool
  default     = false
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
}

variable "features" {
  description = "(Optional) A list of enabled features on the repository. Available features: `ISSUES`, `PROJECTS`, `WIKI`."
  type        = set(string)
  default     = ["ISSUES"]

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

  validation {
    condition = alltrue([
      for strategy in var.merge_strategies :
      contains(["MERGE_COMMIT", "SQUASH", "REBASE"], strategy)
    ])
    error_message = "Available strategies: `MERGE_COMMIT`, `SQUASH`, `REBASE`."
  }
}

variable "delete_branch_on_merge" {
  description = "(Optional) Automatically delete head branch after a pull request is merged. Defaults to true."
  type        = bool
  default     = true
}

variable "topics" {
  description = "(Optional) A list of topics for the repository."
  type        = set(string)
  default     = []
}

variable "issue_labels" {
  description = <<EOF
  (Optional) A list of issue labels for the repository. Each member of `issue_labels` block as defined below.
    (Required) `name` - The name of the label.
    (Required) `color` - A 6 character hex code, without the leading #, identifying the color of the label.
    (Optional) `description` - A short description of the label.
  EOF
  type        = set(map(string))
  default     = []
}

variable "read_teams" {
  description = "(Optional) A list of teams with `read` permission to the repository. You can use GitHub team id or the GitHub team slug."
  type        = set(string)
  default     = []
}

variable "triage_teams" {
  description = "(Optional) A list of teams with `triage` permission to the repository. You can use GitHub team id or the GitHub team slug."
  type        = set(string)
  default     = []
}

variable "write_teams" {
  description = "(Optional) A list of teams with `write` permission to the repository. You can use GitHub team id or the GitHub team slug."
  type        = set(string)
  default     = []
}

variable "maintain_teams" {
  description = "(Optional) A list of teams with `maintain` permission to the repository. You can use GitHub team id or the GitHub team slug."
  type        = set(string)
  default     = []
}

variable "admin_teams" {
  description = "(Optional) A list of teams with `admin` permission to the repository. You can use GitHub team id or the GitHub team slug."
  type        = set(string)
  default     = []
}

variable "read_collaborators" {
  description = "(Optional) A list of users as collaborator with `read` permission to the repository. You can use GitHub username."
  type        = set(string)
  default     = []
}

variable "triage_collaborators" {
  description = "(Optional) A list of users as collaborator with `triage` permission to the repository. You can use GitHub username."
  type        = set(string)
  default     = []
}

variable "write_collaborators" {
  description = "(Optional) A list of users as collaborator with `write` permission to the repository. You can use GitHub username."
  type        = set(string)
  default     = []
}

variable "maintain_collaborators" {
  description = "(Optional) A list of users as collaborator with `maintain` permission to the repository. You can use GitHub username."
  type        = set(string)
  default     = []
}

variable "admin_collaborators" {
  description = "(Optional) A list of users as collaborator with `admin` permission to the repository. You can use GitHub username."
  type        = set(string)
  default     = []
}

variable "default_branch" {
  description = "(Optional) Set the default branch for the repository. Default is `main` branch."
  type        = string
  default     = "main"
}

variable "deploy_keys" {
  description = <<EOF
  (Optional) A list of deploy keys to grant access to the repository. A deploy key is a SSH key. Each member of `deploy_keys` block as defined below.
    (Required) `name` - A name of deploy key.
    (Optional) `key` - A SSH key. Begins with 'ssh-rsa', 'ecdsa-sha2-nistp256', 'ecdsa-sha2-nistp384', 'ecdsa-sha2-nistp521', 'ssh-ed25519', 'sk-ecdsa-sha2-nistp256@openssh.com', or 'sk-ssh-ed25519@openssh.com'.
    (Optional) `writable` - Whether to allow write access to the repository. The key can be used to push to the repository if enabled.
  EOF
  type = list(object({
    name     = string
    key      = string
    writable = bool
  }))
  default = []
}
