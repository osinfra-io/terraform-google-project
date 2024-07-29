terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
    }
  }
}

module "test" {
  source = "../../../"

  # Since we are defining the CIS 2.2 logging sink project in this test, the google_logging_project_bucket_config
  # resource will not be created.

  cis_2_2_logging_sink_project_id = "mock"
  description                     = "mock"
  environment                     = "mock"
  folder_id                       = "0000000000000"

  labels = {
    cost-center = "x000"
    env         = "mock"
    team        = "mock"
    repository  = "mock"
  }

  prefix = "mock"

  services = [
    "compute.googleapis.com"
  ]
}
