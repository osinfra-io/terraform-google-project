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
  description                   = "mock"
  folder_id                     = "0000000000000"

  labels = {
    "mock-key" = "mock-value"
  }

  prefix = "mock"
}
