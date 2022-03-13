output "id" {
  description = "The ID of the project."
  value = try(
    github_repository_project.this[0].id,
    github_organization_project.this[0].id
  )
}

output "name" {
  description = "The name of the project."
  value = try(
    github_repository_project.this[0].name,
    github_organization_project.this[0].name
  )
}

output "description" {
  description = "The description of the team."
  value = try(
    github_repository_project.this[0].body,
    github_organization_project.this[0].body
  )
}

output "level" {
  description = "The level of the project. `REPOSITORY` or `ORGANIZATION`."
  value       = var.level
}

output "repository" {
  description = "The repository which the project is created."
  value       = try(github_repository_project.this[0].repository, null)
}

output "url" {
  description = "The URL of the project."
  value = try(
    github_repository_project.this[0].url,
    github_organization_project.this[0].url
  )
}

output "columns" {
  description = "A list of columns of the project."
  value = {
    for name, column in github_project_column.this :
    name => {
      id   = column.id
      name = name
    }
  }
}
