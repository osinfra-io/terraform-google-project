module "test" {

  # This module will be consumed using the source address of the github repo and not the "../../../" used in this test.
  # source = "github.com/osinfra-io/terraform-google-project?ref=v0.0.0"

  source = "../../../"

  billing_account = var.billing_account

  # Since we are defining the CIS 2.2 logging sink project in this test, the google_logging_project_bucket_config
  # resource will not be created.

  cis_2_2_logging_sink_project_id = "plt-lz-audit01-tf6e-sb" # This project has been created for tests.
  cost_center                     = "x000"
  description                     = "temp"
  environment                     = "sb"
  folder_id                       = "1069400145815"

  labels = {
    key = "value",
  }

  prefix = "kitchen"

  services = [
    "compute.googleapis.com"
  ]
}
