# Project Metadata Item Resource
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_project_metadata_item

# CIS 4.4 Ensure OS login is enabled for a project.
# Enabling OS login binds SSH certificates to IAM users and facilitates effective SSH certificate management.

resource "google_compute_project_metadata_item" "enable_oslogin" {
  key     = "enable-oslogin"
  project = google_project.this.project_id
  value   = true
}

# We disable _Default logging sink at the organization level to avoid duplicate logs
# https://cloud.google.com/logging/docs/default-settings#disable-default-sink
# gcloud alpha logging settings update --organization=${ORGANIZATION_ID} --disable-default-sink
# gcloud alpha logging settings describe --organization=${ORGANIZATION_ID}

# ToDo: We may want to restore the _Default sync filter
# https://cloud.google.com/logging/docs/export/configure_export_v2#restore_the_default_sink_filter

# CIS 2.2 Ensure that sinks are configured for all log entries.
# It is recommended to create a sink that will export copies of all the log entries.

# Project Logging Sink Resource
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/logging_project_sink

resource "google_logging_project_sink" "cis_2_2_logging_sink" {
  destination            = local.cis_2_2_logging_sink_storage_bucket
  name                   = "cis-2-2-logging-sink"
  project                = google_project.this.project_id
  unique_writer_identity = true
}

# Project Logging Bucket Config Resource
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/logging_project_bucket_config

resource "google_logging_project_bucket_config" "cis_2_2_logging_sink" {
  count = var.cis_2_2_logging_sink_project_id != "" ? 0 : 1

  bucket_id      = "cis-2-2-logging-sink"
  location       = "global"
  project        = google_project.this.project_id
  retention_days = 30
}

# Project Resource
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/google_project

resource "google_project" "this" {

  # CIS 3.1 Ensure that the default network does not exist in a project.
  # The default network has a pre-configured network configuration that is not suitable for production use.

  auto_create_network = false
  billing_account     = var.billing_account
  folder_id           = "folders/${var.folder_id}"

  labels = merge(
    {
      cost-center = var.cost_center
    },
    var.labels,
  )

  name       = local.project_id
  project_id = local.project_id
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
  role    = "roles/logging.logWriter"
}

# Random ID Resource
# https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id

resource "random_id" "this" {
  count       = var.random_project_id ? 1 : 0
  prefix      = "tf"
  byte_length = "2"
}
