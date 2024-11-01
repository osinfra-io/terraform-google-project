# <img align="left" width="45" height="45" src="https://user-images.githubusercontent.com/1610100/195462632-f70a64d6-7811-4da3-aa82-c65cbbb74754.png"> Google Cloud Platform - Project Terraform Module

**[GitHub Actions](https://github.com/osinfra-io/terraform-google-project/actions):**

[![Terraform Tests](https://github.com/osinfra-io/terraform-google-project/actions/workflows/test.yml/badge.svg)](https://github.com/osinfra-io/terraform-google-project/actions/workflows/test.yml) [![Dependabot](https://github.com/osinfra-io/terraform-google-project/actions/workflows/dependabot.yml/badge.svg)](https://github.com/osinfra-io/terraform-google-project/actions/workflows/dependabot.yml)

**[Infracost](https://www.infracost.io):**

[![infracost](https://img.shields.io/endpoint?url=https://dashboard.api.infracost.io/shields/json/cbeecfe3-576f-4553-984c-e451a575ee47/repos/f8112db9-d028-45e6-86f5-c35c48a7c0b8/branch/43abfb4e-f8de-4d81-b98d-de0438843e47)](https://dashboard.infracost.io/org/osinfra-io/repos/f8112db9-d028-45e6-86f5-c35c48a7c0b8?tab=settings)

💵 Monthly estimates based on Infracost baseline costs.

## Repository Description

Terraform **example** module for a Google Cloud Platform project.

> [!NOTE]
> We do not recommend consuming this module like you might a [public module](https://registry.terraform.io/browse/modules). It is a baseline, something you can fork, potentially maintain, and modify to fit your organization's needs. Using public modules vs. writing your own has various [drivers and trade-offs](https://docs.osinfra.io/fundamentals/architecture-decision-records/adr-0003) that your organization should evaluate.

## 🔩 Usage

> [!TIP]
> You can check the [tests/fixtures](tests/fixtures) directory for example configurations. These fixtures set up the system for testing by providing all the necessary initial code, thus creating good examples on which to base your configurations.

### Project Names

Project names include a prefix, a description as well as
an environment, for example:

```none
team-example-tf2a-sb
```

> [!NOTE]
> The `tf2a` is a hex output from the random resource. We do not want to duplicate project IDs because project IDs are globally unique. Also, when you delete a project, it goes into a pending deletion state for 30 days, where you can't reuse the project ID. If you want to exclude this from your project name, you can use the variable: `random_project_id = false`

## <img align="left" width="35" height="35" src="https://github.com/osinfra-io/github-organization-management/assets/1610100/39d6ae3b-ccc2-42db-92f1-276a5bc54e65"> Development

Our focus is on the core fundamental practice of platform engineering, Infrastructure as Code.

>Open Source Infrastructure (as Code) is a development model for infrastructure that focuses on open collaboration and applying relative lessons learned from software development practices that organizations can use internally at scale. - [Open Source Infrastructure (as Code)](https://www.osinfra.io)

To avoid slowing down stream-aligned teams, we want to open up the possibility for contributions. The Open Source Infrastructure (as Code) model allows team members external to the platform team to contribute with only a slight increase in cognitive load. This section is for developers who want to contribute to this repository, describing the tools used, the skills, and the knowledge required, along with Terraform documentation.

See the documentation for setting up a local development environment [here](https://docs.osinfra.io/fundamentals/development-setup).

### 🛠️ Tools

- [checkov](https://github.com/bridgecrewio/checkov)
- [infracost](https://github.com/infracost/infracost)
- [pre-commit](https://github.com/pre-commit/pre-commit)
- [pre-commit-terraform](https://github.com/antonbabenko/pre-commit-terraform)
- [terraform-docs](https://github.com/terraform-docs/terraform-docs)

### 📋 Skills and Knowledge

Links to documentation and other resources required to develop and iterate in this repository successfully.

- [apis](https://cloud.google.com/apis/docs/overview)
- [audit logs](https://cloud.google.com/logging/docs/audit)
- [logging metrics](https://cloud.google.com/logging/docs/logs-based-metrics)
- [logging routing](https://cloud.google.com/logging/docs/routing/overview)
- [monitoring alerts](https://cloud.google.com/monitoring/alerts)
- [project](https://cloud.google.com/resource-manager/docs/creating-managing-projects)

### 🔍 Tests

All tests are [mocked](https://developer.hashicorp.com/terraform/language/tests/mocking) allowing us to test the module without creating infrastructure or requiring credentials. The trade-offs are acceptable in favor of speed and simplicity. In a Terraform test, a mocked provider or resource will generate fake data for all computed attributes that would normally be provided by the underlying provider APIs.

```none
terraform init
```

```none
terraform test
```

## 📓 Terraform Documentation

> A child module automatically inherits default (un-aliased) provider configurations from its parent. The provider versions below are informational only and do **not** need to align with the provider configurations from its parent.

<!-- BEGIN_TF_DOCS -->
### Providers

| Name | Version |
|------|---------|
| google | 6.9.0 |
| random | 3.6.3 |

### Modules

| Name | Source | Version |
|------|--------|---------|
| helpers | github.com/osinfra-io/terraform-core-helpers | v0.1.0 |

### Resources

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

### Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| billing\_account | The alphanumeric ID of the billing account this project belongs to | `string` | `"01C550-A2C86B-B8F16B"` | no |
| budget\_notification\_email | The email address to send budget notifications to | `string` | `"billing-admins@osinfra.io"` | no |
| cis\_2\_2\_logging\_bucket\_locked | Boolean to enable CIS 2.2 logging bucket lock | `bool` | `true` | no |
| cis\_2\_2\_logging\_sink\_project\_id | The CIS 2.2 logging sink project ID | `string` | `""` | no |
| deletion\_policy | The deletion policy for the project | `string` | `"PREVENT"` | no |
| description | A short description representing the system, or service you're building in the project for example: `tools` (for a tooling project), `logging` (for a logging project), `services` (for a services project) | `string` | n/a | yes |
| folder\_id | The numeric ID of the folder this project should be created under | `string` | n/a | yes |
| helpers\_cost\_center | The cost center the resources will be billed to, must start with 'x' followed by three or four digits | `string` | n/a | yes |
| helpers\_data\_classification | The data classification of the resources can be public, internal, or confidential | `string` | n/a | yes |
| helpers\_email | The email address of the team responsible for the resources | `string` | n/a | yes |
| helpers\_repository | The repository name (should be in the format 'owner/repo' containing only lowercase alphanumeric characters or hyphens) | `string` | n/a | yes |
| helpers\_team | The team name (should contain only lowercase alphanumeric characters and hyphens) | `string` | n/a | yes |
| key\_ring\_location | The location of the key ring to create | `string` | `"us"` | no |
| labels | A map of key/value pairs to assign to the resources being created | `map(string)` | `{}` | no |
| monthly\_budget\_amount | The monthly budget amount in USD to set for the project | `number` | `5` | no |
| prefix | The team prefix. Examples: - ct (Customer Trust) - plt (Platform) - sec (Security) | `string` | n/a | yes |
| random\_project\_id | If true, a random hex value with a prefix of tf will be added to the `project_id` | `bool` | `true` | no |
| security\_notification\_email | The email address to send security notifications to | `string` | `"security@osinfra.io"` | no |
| services | A list of services to enable in the project | `list(string)` | `[]` | no |

### Outputs

| Name | Description |
|------|-------------|
| cis\_2\_2\_logging\_sink\_project\_id | The CIS 2.2 logging sink benchmark project ID |
| cis\_2\_2\_logging\_sink\_service\_account | The CIS 2.2 logging sink benchmark service account |
| cis\_logging\_metrics\_alert\_policy\_names | The CIS logging metrics alert policy names |
| id | The project ID |
| number | The project number |
| unique\_writer\_identity | The unique identity associated with this sink |
<!-- END_TF_DOCS -->
