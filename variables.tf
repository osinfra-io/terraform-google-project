# Input Variables
# https://www.terraform.io/language/values/variables

variable "billing_id" {
  description = "Billing ID for the project to use"
  type        = string
  sensitive   = true
}

variable "cis_2_2_logging_sink_project_id" {
  description = "The CIS 2.2 logging sink benchmark project ID"
  type        = string
  default     = ""
}

variable "cost_center" {
  description = "Cost center to label the project with"
  type        = string
}

variable "env" {
  description = "This is the environment suffix for example: sb (Sandbox), nonprod (Non-Production), prod (Production)"
  type        = string
  default     = "sb"
}

variable "folder_id" {
  description = "Folder ID for the project to be created in"
  type        = string
}

variable "prefix" {
  description = "This is your team prefix for example: ops (operations)"
  type        = string
  default     = "test"
}

variable "random_project_id" {
  description = "Adds a random hex value with a prefix of tf to the `project_id`"
  type        = bool
  default     = true
}

variable "system" {
  description = "This should be a short name representing the system or part of the system you're building in the project for example: tools (for a set of tooling resources)"
  type        = string
}

variable "labels" {
  description = "A map of labels to add to all resources"
  type        = map(string)
  default     = {}
}
