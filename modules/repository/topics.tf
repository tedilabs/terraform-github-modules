###################################################
# Topics for GitHub Repository
###################################################

resource "github_repository_topics" "this" {
  repository = github_repository.this.name

  topics = var.topics
}
