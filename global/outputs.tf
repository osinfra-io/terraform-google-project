# Output Values
# https://www.terraform.io/language/values/outputs

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

output "project_id" {
  description = "The project ID"
  value       = google_project.this.project_id
}

output "project_number" {
  description = "The project number"
  value       = google_project.this.number
}

output "unique_writer_identity" {
  description = "The unique identity associated with this sink"
  value       = google_logging_project_sink.cis_2_2_logging_sink.writer_identity
}
