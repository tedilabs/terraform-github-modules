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
  default     = ""
  nullable    = false
}

variable "visibility" {
  description = "(Optional) Can be `public`, `private` or `internal`. `internal` visibility is only available if your organization is associated with an enterprise account using GitHub Enterprise Cloud or GitHub Enterprise Server 2.20+."
  type        = string
  default     = "private"
  nullable    = false
}

variable "is_template" {
  description = "(Optional) Whether this is a template repository. Defaults to `false`."
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
  description = "(Optional) Whether to archive the repository instead of deleting on destroy. Defaults to `false`."
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
    (Optional) `init_readme` - Whether to produce an initial commit with README.md in the repository. Defaults to `false`.
    (Optional) `license` - A license tells others what they can and can't do with your code. Use the name of the license template without the extension. For example, `mit` or `mpl-2.0`.
    (Optional) `repository` - Start this repository with a template repository's contents. The full name of the repository is required. A string of the form `owner/repository`.
  EOF
  type = object({
    gitignore   = optional(string)
    init_readme = optional(bool, false)
    license     = optional(string)
    repository  = optional(string)
  })
  default  = {}
  nullable = false
}

variable "features" {
  description = <<EOF
  (Optional) A list of enabled features on the repository. Available features: `DISCUSSIONS`, `ISSUES`, `PROJECTS`, `WIKI`. Defaults to `["ISSUES"]`
  EOF
  type        = set(string)
  default     = ["ISSUES"]
  nullable    = false

  validation {
    condition = alltrue([
      for feature in var.features :
      contains(["DISCUSSIONS", "ISSUES", "PROJECTS", "WIKI"], feature)
    ])
    error_message = "Available features: `DISCUSSIONS`, `ISSUES`, `PROJECTS`, `WIKI`."
  }
}

variable "pull_request" {
  description = <<EOF
  (Optional) A configuration for pull requests on the repository. `pull_request` block as defined below.
    (Optional) `merge_commit` - A configuration for merge commits. `merge_commit` block as defined below.
      (Optional) `enabled` - Whether to allow merge commits for pull requests. Defaults to `false`.
      (Optional) `commit` - A configuration for commit title and message. `commit` block as defined below.
        (Optional) `title` - The default value for a merge commit title. Can be `PR_TITLE` or `MERGE_MESSAGE`. Defaults to `MERGE_MESSAGE`.
        (Optional) `message` - The default value for a merge commit message. Can be `PR_BODY`, `PR_TITLE`, or `BLANK`. Defaults to `BLANK`.
    (Optional) `squash_merge` - A configuration for squash merges. `squash_merge` block as defined below.
      (Optional) `enabled` - Whether to allow squash merges for pull requests. Defaults to `true`.
      (Optional) `commit` - A configuration for commit title and message. `commit` block as defined below.
        (Optional) `title` - The default value for a squash merge commit title. Can be `PR_TITLE` or `COMMIT_OR_PR_TITLE`. Defaults to `PR_TITLE`.
        (Optional) `message` - The default value for a squash merge commit message. Can be `PR_BODY`, `COMMIT_MESSAGES`, or `BLANK`. Defaults to `COMMIT_MESSAGES`.
    (Optional) `rebase_merge` - A configuration for rebase merges. `rebase_merge` block as defined below.
      (Optional) `enabled` - Whether to allow rebase merges for pull requests. Defaults to `true`.
    (Optional) `auto_merge_enabled` - Whether to allow auto-merge on pull requests. Defaults to `false`.
    (Optional) `delete_branch_on_merge` - Whether to delete head branches when pull requests are merged. Defaults to `true`.
  EOF
  type = object({
    merge_commit = optional(object({
      enabled = optional(bool, false)
      commit = optional(object({
        title   = optional(string, "MERGE_MESSAGE")
        message = optional(string, "BLANK")
      }), {})
    }), {})
    squash_merge = optional(object({
      enabled = optional(bool, true)
      commit = optional(object({
        title   = optional(string, "PR_TITLE")
        message = optional(string, "COMMIT_MESSAGES")
      }), {})
    }), {})
    rebase_merge = optional(object({
      enabled = optional(bool, true)
    }), {})
    auto_merge_enabled     = optional(bool, false)
    delete_branch_on_merge = optional(bool, true)
  })
  default  = {}
  nullable = false

  validation {
    condition = contains(
      ["PR_TITLE", "MERGE_MESSAGE"],
      var.pull_request.merge_commit.commit.title
    )
    error_message = "Valid values for `pull_request.merge_commit.commit.title` are `PR_TITLE`, `MERGE_MESSAGE`."
  }

  validation {
    condition = contains(
      ["PR_BODY", "PR_TITLE", "BLANK"],
      var.pull_request.merge_commit.commit.message
    )
    error_message = "Valid values for `pull_request.merge_commit.commit.message` are `PR_BODY`, `PR_TITLE`, `BLANK`."
  }

  validation {
    condition = contains(
      ["PR_TITLE", "COMMIT_OR_PR_TITLE"],
      var.pull_request.squash_merge.commit.title
    )
    error_message = "Valid values for `pull_request.squash_merge.commit.title` are `PR_TITLE`, `COMMIT_OR_PR_TITLE`."
  }

  validation {
    condition = contains(
      ["PR_BODY", "COMMIT_MESSAGES", "BLANK"],
      var.pull_request.squash_merge.commit.message
    )
    error_message = "Valid values for `pull_request.squash_merge.commit.message` are `PR_BODY`, `COMMIT_MESSAGES`, `BLANK`."
  }
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

variable "files" {
  description = <<EOF
  (Optional) A list of files to create and manage within the repository. Each item of `files` block as defined below.
    (Required) `file` - A `file` block as defined below.
      (Required) `path` - The path of the file to manage.
      (Required) `content` - The file content.
    (Optional) `commit` - A `commit` block as defined below.
      (Optional) `author` - Committer author name to use. NOTE: GitHub app users may omit author and email information so GitHub can verify commits as the GitHub App. This maybe useful when a branch protection rule requires signed commits.
      (Optional) `email` - Committer email address to use. NOTE: GitHub app users may omit author and email information so GitHub can verify commits as the GitHub App. This may be useful when a branch protection rule requires signed commits.
      (Optional) `message` - The commit message when creating, updating or deleting the managed file. Defaults to `chore: managed by Terraform.`.
    (Optional) `overwrite_on_create` - Enable overwriting existing files. If set to true it will overwrite an existing file with the same name. If set to false it will fail if there is an existing file with the same name. Defaults to `true`.
  EOF
  type = list(object({
    file = object({
      path    = string
      content = string
    })
    commit = optional(object({
      author  = optional(string)
      email   = optional(string)
      message = optional(string, "chore: managed by Terraform.")
    }), {})
    overwrite_on_create = optional(bool, true)
  }))
  default  = []
  nullable = false
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

variable "pages" {
  description = <<EOF
  (Optional) A configuration of GitHub Pages for the repository. `pages` block as defined below.
    (Optional) `enabled` - Whether to enable GitHub Pages for the repository. GitHub Pages is designed to host your personal, organization, or project pages from a GitHub repository. Defaults to `false`.
    (Optional) `source` - A configuration of the repository source files for the site. `source` block as defined below.
      (Optional) `branch` - The repository branch used to publish the site's source files. Defaults to `gh-pages` branch.
      (Optional) `path` - The repository directory path from which the site publishes. Defaults to `/`.
    (Optional) `cname` - The custom domain for the repository. This can only be set after the repository has been created.
  EOF
  type = object({
    enabled = optional(bool, false)
    source = optional(object({
      branch = optional(string, "gh-pages")
      path   = optional(string, "/")
    }), {})
    cname = optional(string)
  })
  default  = {}
  nullable = false
}

variable "environments" {
  description = <<EOF
  (Optional) A list of environments for the repository. Each item of `environments` block as defined below.
    (Required) `name` - The name of the environment.
    (Optional) `wait_timer` - The amount of time in minutes to wait before allowing deployments to proceed. The default value is `0`.
    (Optional) `allow_admin_to_bypass` - Whether to allow admins to bypass the wait timer and deployment review. The default value is `true`.
    (Optional) `allow_self_approval` - Whether to allow users to approve their own deployment. The default value is `false`.
    (Optional) `reviewers` - A list of reviewers who may review jobs that reference the environment. Each item of `reviewers` block as defined below.
      (Required) `type` - The type of the reviewer. Valid values are `USER` or `TEAM`.
      (Required) `name` - The name of the reviewer. For a user reviewer, the value should be the user's username. For a team reviewer, the value should be the team's slug.
    (Optional) `deployment_policy` - A configuration for deployment policy of the environment. `deployment_policy` block as defined below.
      (Optional) `restriction` - The type of deployment restriction. Valid values are `NONE`, `PROTECTED_BRANCH`, or `CUSTOM`. Defaults to `NONE`.
      (Optional) `branches` - A set of branch name patterns to restrict deployments to when the restriction type is `CUSTOM`.
      (Optional) `tags` - A set of tag name patterns to restrict deployments to when the restriction type is `CUSTOM`.
    (Optional) `variables` - A map of GitHub Actions variables to set for the environment. Defaults to `{}`.
    (Optional) `secrets` - A map of GitHub Actions secrets to set for the environment. Defaults to `{}`.
  EOF
  type = list(object({
    name                  = string
    wait_timer            = optional(number, 0)
    allow_admin_to_bypass = optional(bool, true)
    allow_self_approval   = optional(bool, false)

    reviewers = optional(list(object({
      type = string
      name = string
    })), [])
    deployment_policy = optional(object({
      restriction = optional(string, "NONE")
      branches    = optional(set(string), [])
      tags        = optional(set(string), [])
    }), {})

    variables = optional(map(string), {})
    secrets   = optional(map(string), {})
  }))
  default  = []
  nullable = false
}
