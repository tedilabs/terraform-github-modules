###################################################
# Settings for GitHub Organization Team
###################################################

resource "github_team_settings" "this" {
  team_id = github_team.this.id

  dynamic "review_request_delegation" {
    for_each = var.code_review_auto_assignment.enabled ? [var.code_review_auto_assignment] : []
    iterator = review

    content {
      algorithm    = review.value.algorithm
      member_count = review.value.assignment_count
      notify       = review.value.notify_team_enabled
    }
  }
}
