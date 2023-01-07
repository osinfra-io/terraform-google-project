# <img align="left" width="45" height="45" src="https://user-images.githubusercontent.com/1610100/195462632-f70a64d6-7811-4da3-aa82-c65cbbb74754.png"> Google Cloud Platform - Project Terraform Module

**[GitHub Actions](https://github.com/osinfra-io/terraform-google-project/actions):**

[![Kitchen Tests](https://github.com/osinfra-io/terraform-google-project/actions/workflows/main.yml/badge.svg)](https://github.com/osinfra-io/terraform-google-project/actions/workflows/main.yml) [![Dependabot](https://github.com/osinfra-io/terraform-google-project/actions/workflows/dependabot.yml/badge.svg)](https://github.com/osinfra-io/terraform-google-project/actions/workflows/dependabot.yml)

**[Bridgecrew](https://bridgecrew.io/):**

[![Infrastructure Tests](https://www.bridgecrew.cloud/badges/github/osinfra-io/terraform-google-project/general)](https://www.bridgecrew.cloud/link/badge?vcs=github&fullRepo=osinfra-io%2Fterraform-google-project&benchmark=INFRASTRUCTURE+SECURITY) [![Infrastructure Tests](https://www.bridgecrew.cloud/badges/github/osinfra-io/terraform-google-project/cis_gcp)](https://www.bridgecrew.cloud/link/badge?vcs=github&fullRepo=osinfra-io%2Fterraform-google-project&benchmark=CIS+GCP+V1.1)

**[Infracost](https://www.infracost.io):**

Monthly cost estimates for this module based off these usage values:

[Default Project](test/fixtures/default_project/infracost-usage.yml)
[Logging Project](test/fixtures/logging_project/infracost-usage.yml)

[![infracost](https://img.shields.io/endpoint?label=Default%20Project&url=https://dashboard.api.infracost.io/shields/json/cbeecfe3-576f-4553-984c-e451a575ee47/repos/f8112db9-d028-45e6-86f5-c35c48a7c0b8/branch/43abfb4e-f8de-4d81-b98d-de0438843e47/4f08e74a-4ef9-4846-9fe6-2944f9d77745)](https://dashboard.infracost.io/org/osinfra-io/repos/f8112db9-d028-45e6-86f5-c35c48a7c0b8) [![infracost](https://img.shields.io/endpoint?label=Logging%20Project&url=https://dashboard.api.infracost.io/shields/json/cbeecfe3-576f-4553-984c-e451a575ee47/repos/f8112db9-d028-45e6-86f5-c35c48a7c0b8/branch/43abfb4e-f8de-4d81-b98d-de0438843e47/f297b232-1947-471a-a52c-4cf8b77cfa09)](https://dashboard.infracost.io/org/osinfra-io/repos/f8112db9-d028-45e6-86f5-c35c48a7c0b8)

Terraform example module for a Google Cloud Platform project.

We do not recommend consuming this module like you might a [public module](https://registry.terraform.io/browse/modules). Its purpose is to be a baseline, something you can fork and potentially maintain on your own and modify to fit your organization's needs. Using public modules vs. writing your own have various [drivers and trade-offs](https://github.com/orgs/osinfra-io/discussions/3) that your organization should evaluate.

## Usage

You can check the [test/fixtures](test/fixtures/) directory for example configurations. These fixtures set up the system for the testing process by providing it with all the necessary code to initialize it, thus creating good examples to base your configurations on.

Here is an example of a basic configuration:

```hcl
module "project" {
  source = "github.com/osinfra-io/terraform-google-project?ref=v0.0.0"

  billing_id                      = "555-555-555-555"
  cis_2_2_logging_sink_project_id = "example-logging-project"
  cost_center                     = "x000"
  environment                     = "sb"
  folder_id                       = "1111111111111"

  labels = {
    key = "value",
  }

  prefix = "team"
  system = "example"
}
```

## Project Names

Project names include a prefix, a description as well as
an environment, for example:

```none
team-example-tf3357-sb
```

The `tf3357` is a hex output from the random resource. We do not want to duplicate project IDs because project IDs are globally unique. Also, when you delete a project, it goes into a pending deletion state for 30 days, where you can't reuse the project ID. If you want to exclude this from your project name, you can use the variable: `random_project_id = false`

## <img align="left" width="35" height="35" src="https://user-images.githubusercontent.com/1610100/209029142-410349b7-4b22-40a9-9d4d-729f07e2b4a2.png"> Development

Open Source Infrastructure (as code) is a development model for infrastructure that focuses on open collaboration applying relative lessons learned from software development practices that organizations can use internally at scale. - [Open Source Infrastructure (as Code)](https://www.osinfra.io)

To avoid slowing down [stream-aligned](https://teamtopologies.com/key-concepts) teams, we want to open up the possibility for contributions. The Open Source Infrastructure (as Code) model allows team members external to the platform team to contribute with only a slight increase in cognitive load. This section is for developers who want to contribute to this repository describing the tools used, the skills, and the knowledge required, along with Terraform documentation.

See the documentation for setting up a local development environment [here](https://docs.osinfra.io/development-setup).

### Tools

- [checkov](https://github.com/bridgecrewio/checkov)
- [chef-inspec](https://github.com/inspec/inspec)
- [infracost](https://github.com/infracost/infracost)
- [inspec-gcp](https://github.com/inspec/inspec-gcp)
- [kitchen-terraform](https://github.com/newcontext-oss/kitchen-terraform)
- [pre-commit](https://github.com/pre-commit/pre-commit)
- [pre-commit-terraform](https://github.com/antonbabenko/pre-commit-terraform)
- [terraform-docs](https://github.com/terraform-docs/terraform-docs)

### Skills and Knowledge

Links to documentation and other resources required to develop and iterate in this repository successfully.

- [Google Cloud Platform audit logs](https://cloud.google.com/logging/docs/audit)
- [Google Cloud Platform logging routing](https://cloud.google.com/logging/docs/routing)
- [Google Cloud Platform project](https://cloud.google.com/resource-manager/docs/creating-managing-projects)

### Tests

```none
bundle exec kitchen converge
bundle exec kitchen verify
bundle exec kitchen destroy
```

### Terraform Documentation

A child module automatically inherits its parent's default (un-aliased) provider configurations. The provider versions below are informational only and do **not** need to align with the provider configurations from its parent.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
#### Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider_google) | 4.47.0 |
| <a name="provider_random"></a> [random](#provider_random) | 3.4.3 |

#### Resources

| Name | Type |
|------|------|
| [google_compute_project_metadata_item.enable_oslogin](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_project_metadata_item) | resource |
| [google_logging_project_bucket_config.cis_2_2_logging_sink](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/logging_project_bucket_config) | resource |
| [google_logging_project_sink.cis_2_2_logging_sink](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/logging_project_sink) | resource |
| [google_project.this](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project) | resource |
| [google_project_iam_audit_config.cis_2_1](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_audit_config) | resource |
| [google_project_iam_member.cis_2_2](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_member) | resource |
| [random_id.this](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id) | resource |

#### Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_billing_account"></a> [billing_account](#input_billing_account) | The alphanumeric ID of the billing account this project belongs to | `string` | n/a | yes |
| <a name="input_cost_center"></a> [cost_center](#input_cost_center) | The cost center to label the project with | `string` | n/a | yes |
| <a name="input_folder_id"></a> [folder_id](#input_folder_id) | The numeric ID of the folder this project should be created under. Only one of `org_id` or `folder_id` may be specified | `string` | n/a | yes |
| <a name="input_system"></a> [system](#input_system) | The short name representing the system or part of the system you're building in the project for example: `tools` (for a tooling project), `logging` (for a logging project), `services` (for a services project) | `string` | n/a | yes |
| <a name="input_cis_2_2_logging_sink_project_id"></a> [cis_2_2_logging_sink_project_id](#input_cis_2_2_logging_sink_project_id) | The CIS 2.2 logging sink benchmark project ID | `string` | `""` | no |
| <a name="input_environment"></a> [environment](#input_environment) | The environment suffix for example: `sb` (Sandbox), `nonprod` (Non-Production), `prod` (Production) | `string` | `"sb"` | no |
| <a name="input_labels"></a> [labels](#input_labels) | A set of key/value label pairs to assign to the project | `map(string)` | `{}` | no |
| <a name="input_prefix"></a> [prefix](#input_prefix) | The team prefix for example: `ops` (Operations), `sec` (Security) | `string` | `"test"` | no |
| <a name="input_random_project_id"></a> [random_project_id](#input_random_project_id) | If true, a random hex value with a prefix of tf will be added to the `project_id` | `bool` | `true` | no |

#### Outputs

| Name | Description |
|------|-------------|
| <a name="output_cis_2_2_logging_sink_project_id"></a> [cis_2_2_logging_sink_project_id](#output_cis_2_2_logging_sink_project_id) | The CIS 2.2 logging sink benchmark project ID |
| <a name="output_project_id"></a> [project_id](#output_project_id) | The project ID |
| <a name="output_project_number"></a> [project_number](#output_project_number) | The project number |
| <a name="output_unique_writer_identity"></a> [unique_writer_identity](#output_unique_writer_identity) | The unique identity associated with this sink |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
