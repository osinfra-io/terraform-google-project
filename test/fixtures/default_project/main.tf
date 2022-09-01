# This module block creates a project for logging purposes.

module "logging_project" {
  source = "../../../"

  billing_id  = var.billing_id
  cost_center = var.cost_center
  env         = var.env
  folder_id   = var.folder_id

  labels = {
    key = "value",
  }

  prefix = var.prefix
  system = "logging"
}

# This module block creates a project that uses the above logging project.

module "default_project" {
  source = "../../../"

  billing_id                      = var.billing_id
  cis_2_2_logging_sink_project_id = module.logging_project.project_id
  cost_center                     = var.cost_center
  env                             = var.env
  folder_id                       = var.folder_id

  labels = {
    key = "value",
  }

  prefix = var.prefix
  system = "default"
}
