terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
    }
  }
}

module "test" {
  source = "../../../"

  cis_2_2_logging_sink_project_id = var.cis_2_2_logging_sink_project_id
  description                     = "mock"
  folder_id                       = "0000000000000"
  helpers_cost_center             = var.helpers_cost_center
  helpers_data_classification     = var.helpers_data_classification
  helpers_email                   = var.helpers_email
  helpers_repository              = var.helpers_repository
  helpers_team                    = var.helpers_team

  labels = {
    mock-key = "mock-value"
  }

  prefix = "mock"

  services = [
    "mock.googleapis.com"
  ]
}
