# Terraform Documentation

A child module automatically inherits its parent's default (un-aliased) provider configurations. The provider versions below are informational only and do **not** need to align with the provider configurations from its parent.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | 5.6.0 |
| <a name="provider_random"></a> [random](#provider\_random) | 3.5.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google_billing_budget.project](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/billing_budget) | resource |
| [google_compute_project_metadata_item.enable_oslogin](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_project_metadata_item) | resource |
| [google_kms_crypto_key.cis_2_2_logging_sink](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/kms_crypto_key) | resource |
| [google_kms_crypto_key_iam_member.cis_2_2_logging_sink](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/kms_crypto_key_iam_member) | resource |
| [google_kms_key_ring.this](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/kms_key_ring) | resource |
| [google_logging_metric.cis_logging_metrics](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/logging_metric) | resource |
| [google_logging_project_bucket_config.cis_2_2_logging_sink](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/logging_project_bucket_config) | resource |
| [google_logging_project_sink.cis_2_2_logging_sink](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/logging_project_sink) | resource |
| [google_monitoring_alert_policy.cis_logging_metrics](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/monitoring_alert_policy) | resource |
| [google_monitoring_notification_channel.this](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/monitoring_notification_channel) | resource |
| [google_project.this](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project) | resource |
| [google_project_iam_audit_config.cis_2_1](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_audit_config) | resource |
| [google_project_iam_member.cis_2_2](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_member) | resource |
| [google_project_service.this](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_service) | resource |
| [random_id.this](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id) | resource |
| [google_logging_project_cmek_settings.this](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/logging_project_cmek_settings) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_billing_account"></a> [billing\_account](#input\_billing\_account) | The alphanumeric ID of the billing account this project belongs to | `string` | n/a | yes |
| <a name="input_budget_notification_email"></a> [budget\_notification\_email](#input\_budget\_notification\_email) | The email address to send budget notifications to | `string` | `"billing-admins@osinfra.io"` | no |
| <a name="input_cis_2_2_logging_bucket_locked"></a> [cis\_2\_2\_logging\_bucket\_locked](#input\_cis\_2\_2\_logging\_bucket\_locked) | Boolean to enable CIS 2.2 logging bucket lock | `bool` | `true` | no |
| <a name="input_cis_2_2_logging_sink_project_id"></a> [cis\_2\_2\_logging\_sink\_project\_id](#input\_cis\_2\_2\_logging\_sink\_project\_id) | The CIS 2.2 logging sink project ID | `string` | `""` | no |
| <a name="input_cost_center"></a> [cost\_center](#input\_cost\_center) | The cost center to label the project with | `string` | n/a | yes |
| <a name="input_description"></a> [description](#input\_description) | A short description representing the system, or service you're building in the project for example: `tools` (for a tooling project), `logging` (for a logging project), `services` (for a services project) | `string` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | The environment suffix for example: `sb` (Sandbox), `nonprod` (Non-Production), `prod` (Production) | `string` | `"sb"` | no |
| <a name="input_folder_id"></a> [folder\_id](#input\_folder\_id) | The numeric ID of the folder this project should be created under. Only one of `org_id` or `folder_id` may be specified | `string` | n/a | yes |
| <a name="input_key_ring_location"></a> [key\_ring\_location](#input\_key\_ring\_location) | The location of the key ring to create | `string` | `"us"` | no |
| <a name="input_labels"></a> [labels](#input\_labels) | A set of key/value label pairs to assign to the project | `map(string)` | `{}` | no |
| <a name="input_monthly_budget_amount"></a> [monthly\_budget\_amount](#input\_monthly\_budget\_amount) | The monthly budget amount in USD to set for the project | `number` | `5` | no |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | The team prefix for example: `ops` (Operations), `sec` (Security) | `string` | `"test"` | no |
| <a name="input_random_project_id"></a> [random\_project\_id](#input\_random\_project\_id) | If true, a random hex value with a prefix of tf will be added to the `project_id` | `bool` | `true` | no |
| <a name="input_security_notification_email"></a> [security\_notification\_email](#input\_security\_notification\_email) | The email address to send security notifications to | `string` | `"security@osinfra.io"` | no |
| <a name="input_services"></a> [services](#input\_services) | A list of services to enable in the project | `list(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cis_2_2_logging_sink_project_id"></a> [cis\_2\_2\_logging\_sink\_project\_id](#output\_cis\_2\_2\_logging\_sink\_project\_id) | The CIS 2.2 logging sink benchmark project ID |
| <a name="output_cis_2_2_logging_sink_service_account"></a> [cis\_2\_2\_logging\_sink\_service\_account](#output\_cis\_2\_2\_logging\_sink\_service\_account) | The CIS 2.2 logging sink benchmark service account |
| <a name="output_cis_logging_metrics_alert_policy_names"></a> [cis\_logging\_metrics\_alert\_policy\_names](#output\_cis\_logging\_metrics\_alert\_policy\_names) | The CIS logging metrics alert policy names, we need these to test the resources with inspec |
| <a name="output_project_id"></a> [project\_id](#output\_project\_id) | The project ID |
| <a name="output_project_number"></a> [project\_number](#output\_project\_number) | The project number |
| <a name="output_unique_writer_identity"></a> [unique\_writer\_identity](#output\_unique\_writer\_identity) | The unique identity associated with this sink |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
