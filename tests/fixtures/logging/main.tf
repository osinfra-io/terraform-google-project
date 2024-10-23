terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
    }
  }
}

module "test" {
  source = "../../../"

  cis_2_2_logging_bucket_locked = false
  cost_center                   = var.cost_center
  data_classification           = var.data_classification
  description                   = "mock"
  email                         = var.email
  folder_id                     = "0000000000000"

  labels = {
    mock-key = "mock-value"
  }

  prefix     = "mock"
  repository = var.repository
  team       = var.team
}
