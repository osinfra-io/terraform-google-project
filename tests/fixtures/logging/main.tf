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
  environment                   = var.environment
  folder_id                     = "0000000000000"
  labels                        = local.labels
  prefix                        = "mock"
}
