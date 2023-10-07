# Input Variables
# https://www.terraform.io/language/values/variables

variable "billing_account" {
  description = "The alphanumeric ID of the billing account this project belongs to"
  type        = string
  sensitive   = true
}

variable "budget_notification_email" {
  description = "The email address to send budget notifications to"
  type        = string
  default     = "billing-admins@osinfra.io"
}

variable "cis_2_2_logging_bucket_lock" {
  description = "Boolean to enable CIS 2.2 logging bucket lock"
  type        = bool
  default     = true
}

variable "cis_2_2_logging_sink_project_id" {
  description = "The CIS 2.2 logging sink benchmark project ID"
  type        = string
  default     = ""
}

variable "cost_center" {
  description = "The cost center to label the project with"
  type        = string
}

variable "description" {
  description = "A short description representing the system, or service you're building in the project for example: `tools` (for a tooling project), `logging` (for a logging project), `services` (for a services project)"
  type        = string
}

variable "environment" {
  description = "The environment suffix for example: `sb` (Sandbox), `nonprod` (Non-Production), `prod` (Production)"
  type        = string
  default     = "sb"
}

variable "folder_id" {
  description = "The numeric ID of the folder this project should be created under. Only one of `org_id` or `folder_id` may be specified"
  type        = string
}

variable "monthly_budget_amount" {
  description = "The monthly budget amount in USD to set for the project"
  type        = number
  default     = 5
}

variable "prefix" {
  description = "The team prefix for example: `ops` (Operations), `sec` (Security)"
  type        = string
  default     = "test"
}

variable "random_project_id" {
  description = "If true, a random hex value with a prefix of tf will be added to the `project_id`"
  type        = bool
  default     = true
}

variable "security_notification_email" {
  description = "The email address to send security notifications to"
  type        = string
  default     = "security@osinfra.io"
}

variable "services" {
  description = "A list of services to enable in the project"
  type        = list(string)
  default     = []
}

variable "labels" {
  description = "A set of key/value label pairs to assign to the project"
  type        = map(string)
  default     = {}
}
