# Input Variables
# https://www.terraform.io/language/values/variables

variable "billing_account" {
  description = "The alphanumeric ID of the billing account this project belongs to"
  type        = string
  default     = "01C550-A2C86B-B8F16B"
}

variable "budget_notification_email" {
  description = "The email address to send budget notifications to"
  type        = string
  default     = "billing-admins@osinfra.io"
}

variable "cis_2_2_logging_bucket_locked" {
  description = "Boolean to enable CIS 2.2 logging bucket lock"
  type        = bool
  default     = true
}

variable "cis_2_2_logging_sink_project_id" {
  description = "The CIS 2.2 logging sink project ID"
  type        = string
  default     = ""
}

variable "cost_center" {
  description = "The cost center the resources will be billed to, must start with 'x' followed by three or four digits"
  type        = string
}

variable "data_classification" {
  description = "The data classification of the resources can be public, internal, or confidential"
  type        = string
}

variable "deletion_policy" {
  description = "The deletion policy for the project"
  type        = string
  default     = "PREVENT"
}

variable "description" {
  description = "A short description representing the system, or service you're building in the project for example: `tools` (for a tooling project), `logging` (for a logging project), `services` (for a services project)"
  type        = string
}

variable "email" {
  description = "The email address of the team responsible for the resources"
  type        = string
}

variable "folder_id" {
  description = "The numeric ID of the folder this project should be created under. Only one of `org_id` or `folder_id` may be specified"
  type        = string
}

variable "key_ring_location" {
  description = "The location of the key ring to create"
  type        = string
  default     = "us"
}

variable "labels" {
  description = "A map of key/value pairs to assign to the resources being created"
  type        = map(string)
  default     = {}
}

variable "monthly_budget_amount" {
  description = "The monthly budget amount in USD to set for the project"
  type        = number
  default     = 5
}

variable "prefix" {
  description = "The team prefix for example: `ct` (Customer Trust), `plt` (Platform), `sec` (Security)"
  type        = string
}

variable "random_project_id" {
  description = "If true, a random hex value with a prefix of tf will be added to the `project_id`"
  type        = bool
  default     = true
}

variable "repository" {
  description = "The repository name (should be in the format 'owner/repo') containing only lowercase alphanumeric characters or hyphens"
  type        = string
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

variable "team" {
  description = "The team name (should contain only lowercase alphanumeric characters and hyphens)"
  type        = string
}
