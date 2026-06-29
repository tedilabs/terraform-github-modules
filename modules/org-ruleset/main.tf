###################################################
# Organization Ruleset
###################################################

resource "github_organization_ruleset" "this" {
  name        = var.name
  target      = var.target
  enforcement = lower(var.status)


  ## Bypass Actors
  dynamic "bypass_actors" {
    for_each = var.bypass_list
    iterator = item

    content {
      actor_type  = item.value.actor.type
      actor_id    = item.value.actor.id
      bypass_mode = item.value.mode
    }
  }


  ## Conditions
  conditions {
    ref_name {
      include = var.conditions.ref_name.include
      exclude = var.conditions.ref_name.exclude
    }

    dynamic "repository_name" {
      for_each = var.conditions.repository_name != null ? [var.conditions.repository_name] : []

      content {
        include   = repository_name.value.include
        exclude   = repository_name.value.exclude
        protected = repository_name.value.protected
      }
    }

    repository_id = var.conditions.repository_ids
  }


  ## Rules
  rules {
    creation                = var.rules.creation
    update                  = var.rules.update
    deletion                = var.rules.deletion
    required_linear_history = var.rules.required_linear_history
    required_signatures     = var.rules.required_signatures
    non_fast_forward        = var.rules.non_fast_forward

    dynamic "pull_request" {
      for_each = var.rules.pull_request != null ? [var.rules.pull_request] : []

      content {
        dismiss_stale_reviews_on_push     = pull_request.value.dismiss_stale_reviews_on_push
        require_code_owner_review         = pull_request.value.require_code_owner_review
        require_last_push_approval        = pull_request.value.require_last_push_approval
        required_approving_review_count   = pull_request.value.required_approving_review_count
        required_review_thread_resolution = pull_request.value.required_review_thread_resolution
      }
    }

    dynamic "required_status_checks" {
      for_each = var.rules.required_status_checks != null ? [var.rules.required_status_checks] : []

      content {
        dynamic "required_check" {
          for_each = required_status_checks.value.checks

          content {
            context        = required_check.value.context
            integration_id = required_check.value.integration_id
          }
        }

        strict_required_status_checks_policy = required_status_checks.value.strict_required_status_checks_policy
      }
    }

    dynamic "required_workflows" {
      for_each = var.rules.required_workflows != null ? [var.rules.required_workflows] : []

      content {
        dynamic "required_workflow" {
          for_each = required_workflows.value.workflows

          content {
            repository_id = required_workflow.value.repository_id
            path          = required_workflow.value.path
            ref           = required_workflow.value.ref
          }
        }

        do_not_enforce_on_create = required_workflows.value.do_not_enforce_on_create
      }
    }

    dynamic "required_code_scanning" {
      for_each = var.rules.required_code_scanning != null ? [var.rules.required_code_scanning] : []

      content {
        dynamic "required_code_scanning_tool" {
          for_each = required_code_scanning.value.tools

          content {
            tool                      = required_code_scanning_tool.value.tool
            alerts_threshold          = required_code_scanning_tool.value.alerts_threshold
            security_alerts_threshold = required_code_scanning_tool.value.security_alerts_threshold
          }
        }
      }
    }

    dynamic "branch_name_pattern" {
      for_each = var.rules.branch_name_pattern != null ? [var.rules.branch_name_pattern] : []

      content {
        operator = branch_name_pattern.value.operator
        pattern  = branch_name_pattern.value.pattern
        name     = branch_name_pattern.value.name
        negate   = branch_name_pattern.value.negate
      }
    }

    dynamic "tag_name_pattern" {
      for_each = var.rules.tag_name_pattern != null ? [var.rules.tag_name_pattern] : []

      content {
        operator = tag_name_pattern.value.operator
        pattern  = tag_name_pattern.value.pattern
        name     = tag_name_pattern.value.name
        negate   = tag_name_pattern.value.negate
      }
    }

    dynamic "commit_message_pattern" {
      for_each = var.rules.commit_message_pattern != null ? [var.rules.commit_message_pattern] : []

      content {
        operator = commit_message_pattern.value.operator
        pattern  = commit_message_pattern.value.pattern
        name     = commit_message_pattern.value.name
        negate   = commit_message_pattern.value.negate
      }
    }

    dynamic "commit_author_email_pattern" {
      for_each = var.rules.commit_author_email_pattern != null ? [var.rules.commit_author_email_pattern] : []

      content {
        operator = commit_author_email_pattern.value.operator
        pattern  = commit_author_email_pattern.value.pattern
        name     = commit_author_email_pattern.value.name
        negate   = commit_author_email_pattern.value.negate
      }
    }

    dynamic "committer_email_pattern" {
      for_each = var.rules.committer_email_pattern != null ? [var.rules.committer_email_pattern] : []

      content {
        operator = committer_email_pattern.value.operator
        pattern  = committer_email_pattern.value.pattern
        name     = committer_email_pattern.value.name
        negate   = committer_email_pattern.value.negate
      }
    }
  }
}
