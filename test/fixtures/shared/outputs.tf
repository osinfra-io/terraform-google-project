# Output Values
# https://www.terraform.io/language/values/outputs

output "project_id" {
  value = module.test.project_id
}

output "project_number" {
  value = module.test.project_number
}
