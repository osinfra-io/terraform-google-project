# Output Values
# https://opentofu.org/docs/language/values/outputs

output "cis_logging_metrics_alert_policy_names" {
  description = "The CIS logging metrics alert policy names, we need these to test the resources with inspec"
  value = [
    for k, v in local.cis_logging_metrics :
    {
      key   = k
      value = google_monitoring_alert_policy.cis_logging_metrics[k].name
    }
  ]
}

output "cis_2_2_logging_sink_project_id" {
  description = "The CIS 2.2 logging sink benchmark project ID"
  value       = local.cis_2_2_logging_sink_project_id
}

output "cis_2_2_logging_sink_service_account" {
  description = "The CIS 2.2 logging sink benchmark service account"
  value       = length(data.google_logging_project_cmek_settings.this) > 0 ? data.google_logging_project_cmek_settings.this[0].service_account_id : null
}

output "id" {
  description = "The project ID"
  value       = google_project.this.project_id
}

output "number" {
  description = "The project number"
  value       = google_project.this.number
}

output "unique_writer_identity" {
  description = "The unique identity associated with this sink"
  value       = google_logging_project_sink.cis_2_2_logging_sink.writer_identity
}
