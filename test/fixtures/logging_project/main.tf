module "test" {

  # This module will be consumed using the source address of the github repo and not the "../../../" used in this test.
  # source = "git@github.com:osinfra-io/terraform-google-project?ref=v0.0.0"

  source = "../../../"

  billing_account = var.billing_account
  cost_center     = "x000"
  description     = "temp"
  environment     = "sb"
  folder_id       = "927951427023"

  labels = {
    key = "value",
  }

  prefix = "kitchen"
}
