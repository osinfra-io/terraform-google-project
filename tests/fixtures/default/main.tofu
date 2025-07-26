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

  labels = {
    "mock-key" = "mock-value"
  }

  prefix = "mock"

  services = [
    "mock.googleapis.com"
  ]
}
