# Google Cloud Provider
# https://registry.terraform.io/providers/hashicorp/google/latest/docs

# The google_billing_budget resource requires this if you are using User ADCs (Application Default Credentials).
# Your account must have the serviceusage.services.use permission on the billing_project you defined as well.
# The following APIs must be enabled on the billing_project:
# - billingbudgets.googleapis.com
# - cloudresourcemanager.googleapis.com
# - serviceusage.googleapis.com

provider "google" {
  billing_project       = "testing-kitchen-tf11-sb"
  user_project_override = true
}

module "test" {

  # This module will be consumed using the source address of the github repo and not the "../../../" used in this test.
  # source = "git@github.com:osinfra-io/terraform-google-project?ref=v0.0.0"

  source = "../../../global"

  billing_account = var.billing_account
  cost_center     = "x000"
  description     = "temp"
  environment     = "sb"
  folder_id       = "1069400145815"

  labels = {
    key = "value",
  }

  prefix = "kitchen"
}
