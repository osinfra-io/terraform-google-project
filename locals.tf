# Local Values
# https://www.terraform.io/language/values/locals

locals {
  base_project_id                     = "${var.prefix}-${var.system}-${var.env}"
  cis_2_2_logging_sink_project_id     = var.cis_2_2_logging_sink_project_id == "" ? google_project.this.project_id : var.cis_2_2_logging_sink_project_id
  cis_2_2_logging_sink_storage_bucket = var.cis_2_2_logging_sink_project_id == "" ? "logging.googleapis.com/${google_logging_project_bucket_config.cis_2_2_logging_sink[0].name}" : "logging.googleapis.com/projects/${var.cis_2_2_logging_sink_project_id}/locations/global/buckets/cis-2-2-logging-sink"

  # Format Function
  # https://www.terraform.io/language/functions/format

  project_id = var.random_project_id ? format(
    "%s-%s-%s-%s",
    var.prefix,
    var.system,
    random_id.this[0].hex,
    var.env,
  ) : local.base_project_id
}
