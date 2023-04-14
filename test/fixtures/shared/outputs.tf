# Output Values
# https://www.terraform.io/language/values/outputs

output "cis_2_2_logging_sink_project_id" {
  value     = module.test.cis_2_2_logging_sink_project_id
  sensitive = true
}

output "project_id" {
  value = module.test.project_id
}

output "project_number" {
  value = module.test.project_number
}

output "unique_writer_identity" {
  value = module.test.unique_writer_identity
}
