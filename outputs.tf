# Output Values
# https://www.terraform.io/language/values/outputs

output "project_id" {
  description = "The project ID"
  value       = google_project.this.project_id
}

output "project_number" {
  description = "The project number"
  value       = google_project.this.number
}
