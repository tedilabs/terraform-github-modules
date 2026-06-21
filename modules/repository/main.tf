locals {
  custom_property_value_types = {
    "STRING"        = "string"
    "SINGLE_SELECT" = "single_select"
    "MULTI_SELECT"  = "multi_select"
    "BOOL"          = "true_false"
  }
}


###################################################
# GitHub Repository
###################################################

# INFO: Not supported attributes
# - `private`
# INFO: Deprecated attributes
# - `has_downloads`
# INFO: Use a separate resource
# - `topics`
# - `default_branch`
# - `vulnerability_alerts`
resource "github_repository" "this" {
  name         = var.name
  description  = var.description
  homepage_url = var.homepage

  visibility         = var.visibility
  archived           = var.archived
  archive_on_destroy = var.archive_on_destroy


  ## Template
  is_template = var.is_template

  auto_init          = var.template.init_readme
  license_template   = var.template.license
  gitignore_template = var.template.gitignore

  dynamic "template" {
    for_each = var.template.repository != null ? [var.template.repository] : []

    content {
      owner      = split("/", template.value)[0]
      repository = split("/", template.value)[1]
    }
  }


  ## Features
  has_discussions = contains(var.features, "DISCUSSIONS")
  has_issues      = contains(var.features, "ISSUES")
  has_projects    = contains(var.features, "PROJECTS")
  has_wiki        = contains(var.features, "WIKI")


  ## Pull Request
  allow_merge_commit = var.pull_request.merge_commit.enabled
  merge_commit_title = (var.pull_request.merge_commit.enabled
    ? var.pull_request.merge_commit.commit.title
    : null
  )
  merge_commit_message = (var.pull_request.merge_commit.enabled
    ? var.pull_request.merge_commit.commit.message
    : null
  )

  allow_squash_merge = var.pull_request.squash_merge.enabled
  squash_merge_commit_title = (var.pull_request.squash_merge.enabled
    ? var.pull_request.squash_merge.commit.title
    : null
  )
  squash_merge_commit_message = (var.pull_request.squash_merge.enabled
    ? var.pull_request.squash_merge.commit.message
    : null
  )

  allow_rebase_merge = var.pull_request.rebase_merge.enabled

  allow_auto_merge       = var.pull_request.auto_merge_enabled
  delete_branch_on_merge = var.pull_request.delete_branch_on_merge


  ## Pages
  dynamic "pages" {
    for_each = var.pages.enabled ? [var.pages] : []

    content {
      source {
        branch = pages.value.source.branch
        path   = pages.value.source.path
      }
      cname = pages.value.cname
    }
  }

  lifecycle {
    ignore_changes = [
      auto_init,
      license_template,
      gitignore_template,
      template,
      topics,
    ]
  }
}


###################################################
# Vulnerability Alerts for GitHub Repository
###################################################

resource "github_repository_vulnerability_alerts" "this" {
  repository = github_repository.this.name
  enabled    = contains(var.features, "DEPENDABOT_ALERTS")
}


###################################################
# Custom Properties for GitHub Repository
###################################################

resource "github_repository_custom_property" "this" {
  for_each = {
    for name, property in var.custom_properties :
    name => property
  }

  repository = github_repository.this.name

  property_name  = each.key
  property_type  = local.custom_property_value_types[each.value.type]
  property_value = each.value.value
}


###################################################
# Files for GitHub Repository
###################################################

# INFO: Not supported attributes
# - `autocreate_branch_source_branch`
# - `autocreate_branch_source_sha`
resource "github_repository_file" "this" {
  for_each = (var.default_branch != null
    ? {
      for file in var.files :
      file.file.path => file
    }
    : {}
  )

  repository = github_repository.this.name
  branch     = github_branch_default.this[0].branch

  file    = each.value.file.path
  content = each.value.file.content

  commit_author  = each.value.commit.author
  commit_email   = each.value.commit.email
  commit_message = each.value.commit.message

  overwrite_on_create = each.value.overwrite_on_create

  autocreate_branch = false
}
