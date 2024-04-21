# Logging Project CMEK Settings Data Source
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/logging_project_cmek_settings

data "google_logging_project_cmek_settings" "this" {
  count = var.cis_2_2_logging_sink_project_id != "" ? 0 : 1

  project = google_project.this.project_id

  depends_on = [
    google_project_service.this
  ]
}

# Billing Budget Resource
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/billing_budget

resource "google_billing_budget" "project" {
  all_updates_rule {
    monitoring_notification_channels = [
      google_monitoring_notification_channel.this["budget"].name
    ]
  }
  amount {
    specified_amount {
      currency_code = "USD"
      units         = var.monthly_budget_amount
    }
  }

  billing_account = var.billing_account

  budget_filter {
    projects = ["projects/${google_project.this.number}"]
  }

  display_name = "Monthly: ${google_project.this.project_id}"

  threshold_rules {
    threshold_percent = 0.50
    spend_basis       = "CURRENT_SPEND"
  }

  threshold_rules {
    threshold_percent = 0.75
    spend_basis       = "CURRENT_SPEND"
  }

  threshold_rules {
    threshold_percent = 1.0
    spend_basis       = "CURRENT_SPEND"
  }
}

# Project Metadata Item Resource
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_project_metadata_item

# CIS 4.4 Ensure OS login is enabled for a project.
# Enabling OS login binds SSH certificates to IAM users and facilitates effective SSH certificate management.

resource "google_compute_project_metadata_item" "enable_oslogin" {
  key     = "enable-oslogin"
  project = google_project.this.project_id
  value   = true

  depends_on = [
    google_project_service.this
  ]
}

# KMS Crypto Key Resource
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/kms_crypto_key

resource "google_kms_crypto_key" "cis_2_2_logging_sink" {
  count = var.cis_2_2_logging_sink_project_id != "" ? 0 : 1

  key_ring        = google_kms_key_ring.this.id
  labels          = var.labels
  name            = "cis-2-2-logging-sink"
  rotation_period = "7776000s"
}

# KMS Key Ring Resource
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/kms_key_ring

resource "google_kms_key_ring" "this" {
  location = var.key_ring_location
  name     = "default"
  project  = google_project.this.project_id

  depends_on = [
    google_project_service.this
  ]
}

# KMS Crypto Key IAM Member Resource
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/kms_crypto_key_iam_member

resource "google_kms_crypto_key_iam_member" "cis_2_2_logging_sink" {
  count = var.cis_2_2_logging_sink_project_id != "" ? 0 : 1

  crypto_key_id = google_kms_crypto_key.cis_2_2_logging_sink[0].id
  member        = "serviceAccount:${data.google_logging_project_cmek_settings.this[0].service_account_id}"
  role          = "roles/cloudkms.cryptoKeyEncrypterDecrypter"
}

# Logging Metric Resource
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/logging_metric

resource "google_logging_metric" "cis_logging_metrics" {
  for_each = local.cis_logging_metrics

  description = each.value.description
  filter      = each.value.filter
  name        = each.key
  project     = google_project.this.project_id
}

# We disable _Default logging sink at the organization level to avoid duplicate logs
# https://cloud.google.com/logging/docs/default-settings#disable-default-sink
# gcloud alpha logging settings update --organization=${ORGANIZATION_ID} --disable-default-sink
# gcloud alpha logging settings describe --organization=${ORGANIZATION_ID}

# CIS 2.2 Ensure that sinks are configured for all log entries.
# It is recommended to create a sink that will export copies of all the log entries.

# Project Logging Sink Resource
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/logging_project_sink

resource "google_logging_project_sink" "cis_2_2_logging_sink" {
  destination = local.cis_2_2_logging_sink_storage_bucket

  exclusions {
    name = "default"
    filter = join(" AND ", [
      "NOT LOG_ID(\"cloudaudit.googleapis.com/activity\")",
      "NOT LOG_ID(\"externalaudit.googleapis.com/activity\")",
      "NOT LOG_ID(\"cloudaudit.googleapis.com/system_event\")",
      "NOT LOG_ID(\"externalaudit.googleapis.com/system_event\")",
      "NOT LOG_ID(\"cloudaudit.googleapis.com/access_transparency\")",
      "NOT LOG_ID(\"externalaudit.googleapis.com/access_transparency\")"
    ])
  }

  name                   = "cis-2-2-logging-sink"
  project                = google_project.this.project_id
  unique_writer_identity = true

  depends_on = [
    google_project_service.this
  ]
}

# Project Logging Bucket Config Resource
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/logging_project_bucket_config

resource "google_logging_project_bucket_config" "cis_2_2_logging_sink" {
  count = var.cis_2_2_logging_sink_project_id != "" ? 0 : 1

  bucket_id = "cis-2-2-logging-sink"

  cmek_settings {
    kms_key_name = google_kms_crypto_key.cis_2_2_logging_sink[0].id
  }

  location       = var.key_ring_location
  locked         = var.cis_2_2_logging_bucket_locked
  project        = google_project.this.project_id
  retention_days = 30
}

# Monitoring Alert Policy Resource
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/monitoring_alert_policy

resource "google_monitoring_alert_policy" "cis_logging_metrics" {
  for_each = local.cis_logging_metrics

  combiner = "OR"

  conditions {
    condition_threshold {
      aggregations {
        alignment_period     = "60s"
        cross_series_reducer = "REDUCE_COUNT"
        per_series_aligner   = "ALIGN_DELTA"
      }
      duration   = "0s"
      comparison = "COMPARISON_GT"
      filter     = "metric.type=\"logging.googleapis.com/user/${each.key}\" AND resource.type=\"${each.value.resource_type}\""
    }
    display_name = google_logging_metric.cis_logging_metrics[each.key].name
  }

  display_name = each.value.displayName

  documentation {
    content   = each.value.description
    mime_type = "text/markdown"
  }

  notification_channels = [
    google_monitoring_notification_channel.this["security"].name
  ]

  project = google_project.this.project_id

  user_labels = merge(
    {
      status = each.value.status
    },
    var.labels
  )
}

# Monitoring Notification Channel Resource
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/monitoring_notification_channel

resource "google_monitoring_notification_channel" "this" {
  for_each = local.monitoring_notification_channels

  description  = each.value.description
  display_name = each.value.display_name
  force_delete = true

  labels = {
    "email_address" = each.value.email_address
  }

  project     = google_project.this.project_id
  type        = "email"
  user_labels = var.labels
}

# Project Resource
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/google_project

resource "google_project" "this" {

  # CIS 3.1 Ensure that the default network does not exist in a project.
  # The default network has a pre-configured network configuration that is not suitable for production use.

  auto_create_network = false
  billing_account     = var.billing_account
  folder_id           = "folders/${var.folder_id}"
  labels              = var.labels
  name                = local.project_id
  project_id          = local.project_id
}

# IAM Audit Config Resource
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/google_project_iam#google_project_iam_audit_config

# CIS 2.1 Ensure that cloud audit logging is configured properly across all services and all users from a project.
# It is recommended that Cloud Audit Logging is configured to track all admin activities and read, write access to user data.

resource "google_project_iam_audit_config" "cis_2_1" {
  project = google_project.this.project_id
  service = "allServices"

  dynamic "audit_log_config" {
    for_each = toset(
      [
        "ADMIN_READ",
        "DATA_READ",
        "DATA_WRITE"
      ]
    )
    content {
      log_type = audit_log_config.key
    }
  }
}

# Project IAM Member Resource
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/google_project_iam

resource "google_project_iam_member" "cis_2_2" {

  # We do not need to add the role to the project if the log bucket and sync are in the same project.

  count = var.cis_2_2_logging_sink_project_id == "" ? 0 : 1

  member  = google_logging_project_sink.cis_2_2_logging_sink.writer_identity
  project = local.cis_2_2_logging_sink_project_id
  role    = "roles/logging.bucketWriter"
}

# Project Service Resource
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/google_project_service

resource "google_project_service" "this" {
  for_each = local.services

  disable_dependent_services = true
  project                    = google_project.this.project_id
  service                    = each.key
}

# Random ID Resource
# https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id

resource "random_id" "this" {
  count = var.random_project_id ? 1 : 0

  prefix      = "tf"
  byte_length = "1"
}
