# Google Cloud Provider
# https://registry.terraform.io/providers/hashicorp/google/latest/docs

# The google_billing_budget resource requires this if you are using User ADCs (Application Default Credentials).
# The following APIs must be enabled on the billing_project:
# - billingbudgets.googleapis.com
# - cloudresourcemanager.googleapis.com

provider "google" {
  billing_project       = "ptl-lz-terraform-tf91-sb"
  user_project_override = true
}

module "test" {

  # This module will be consumed using the source address of the github repo and not the "../../../" used in this test.
  # source = "git@github.com:osinfra-io/terraform-google-project?ref=v0.0.0"

  source = "../../../global"

  cis_2_2_logging_bucket_locked = false
  description                   = "test"
  environment                   = "sb"
  folder_id                     = "1069400145815"

  labels = {
    cost-center = "x000"
    env         = "sb"
    team        = "testing"
    repository  = "terraform-google-project"
  }

  prefix = "terraform"
}
