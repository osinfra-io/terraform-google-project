# Output Values
# https://www.terraform.io/language/values/outputs

output "cis_logging_metrics_alert_policy_names" {
  value = module.test.cis_logging_metrics_alert_policy_names
}

output "cis_2_2_logging_sink_project_id" {
  value = module.test.cis_2_2_logging_sink_project_id
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
