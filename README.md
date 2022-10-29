# <img align="left" width="45" height="45" src="https://user-images.githubusercontent.com/1610100/195462632-f70a64d6-7811-4da3-aa82-c65cbbb74754.png"> Google Cloud Platform - Project Terraform Module

**[GitHub Actions](https://github.com/osinfra-io/terraform-google-project/actions):**

[![Kitchen Tests](https://github.com/osinfra-io/terraform-google-project/actions/workflows/main.yml/badge.svg)](https://github.com/osinfra-io/terraform-google-project/actions/workflows/main.yml) [![Dependabot](https://github.com/osinfra-io/terraform-google-project/actions/workflows/dependabot.yml/badge.svg)](https://github.com/osinfra-io/terraform-google-project/actions/workflows/dependabot.yml)

**[Bridgecrew](https://bridgecrew.io/):**

[![Infrastructure Tests](https://www.bridgecrew.cloud/badges/github/osinfra-io/terraform-google-project/cis_gcp)](https://www.bridgecrew.cloud/link/badge?vcs=github&fullRepo=osinfra-io%2Fterraform-google-project&benchmark=CIS+GCP+V1.1)

Terraform example module for a Google Cloud Platform project.

We do not recommend consuming this module like you might a [public module](https://registry.terraform.io/browse/modules). Its purpose is to be a baseline, something you can fork and potentially maintain on your own and modify to fit your organization's needs. Using public modules vs. writing your own have various drivers and trade-offs that your organization should evaluate.

## Usage

We do not pin modules to versions in our documentation examples because of the difficulty of keeping the versions in sync with the latest released versions. We highly recommend pinning a version in your root module so that your infrastructure remains stable.

You can check the [test/fixtures](test/fixtures/) directory for example configurations. These fixtures set up the system for the testing process by providing it with all the necessary code to initialize it, thus creating good examples to base your configurations on.

Here is an example of a basic configuration:

```hcl
module "project" {
  source  = "git@github.com:osinfra-io/terraform-google-project?ref=v0.0.0"

  billing_id                      = "555-555-555-555"
  cis_2_2_logging_sink_project_id = "example-logging-project"
  cost_center                     = "x000"
  env                             = "sb"
  folder_id                       = "1111111111111"

  labels = {
    key = "value",
  }

  prefix = "example-team"
  system = "example"
}
```

## Project Names

Project names include a prefix, a description as well as
an environment, for example:

```none
test-tools-tf3357-sb
```

The `tf3357` is a hex output from the random resource. We do not want to duplicate project IDs because project IDs are globally unique. Also, when you delete a project, it goes into a pending deletion state for 30 days, where you can't reuse the project ID. If you want to exclude this from your project name, you can use the variable: `random_project_id = false`

## Terraform Documentation

A child module automatically inherits its parent's default (un-aliased) provider configurations. The provider versions below are informational only and do **not** need to align with the provider configurations from its parent.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
### Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider_google) | 4.40.0 |
| <a name="provider_random"></a> [random](#provider_random) | 3.4.3 |

### Resources

| Name | Type |
|------|------|
| [google_compute_project_metadata_item.enable_oslogin](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_project_metadata_item) | resource |
| [google_logging_project_bucket_config.cis_2_2_logging_sink](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/logging_project_bucket_config) | resource |
| [google_logging_project_sink.cis_2_2_logging_sink](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/logging_project_sink) | resource |
| [google_project.this](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project) | resource |
| [google_project_iam_audit_config.cis_2_1](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_audit_config) | resource |
| [google_project_iam_member.cis_2_2](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_member) | resource |
| [random_id.this](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id) | resource |

### Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_billing_account"></a> [billing_account](#input_billing_account) | The alphanumeric ID of the billing account this project belongs to | `string` | n/a | yes |
| <a name="input_cost_center"></a> [cost_center](#input_cost_center) | The cost center to label the project with | `string` | n/a | yes |
| <a name="input_folder_id"></a> [folder_id](#input_folder_id) | The numeric ID of the folder this project should be created under. Only one of `org_id` or `folder_id` may be specified | `string` | n/a | yes |
| <a name="input_system"></a> [system](#input_system) | The short name representing the system or part of the system you're building in the project for example: `tools` (for a tooling project), `logging` (for a logging project), `services` (for a services project) | `string` | n/a | yes |
| <a name="input_cis_2_2_logging_sink_project_id"></a> [cis_2_2_logging_sink_project_id](#input_cis_2_2_logging_sink_project_id) | The CIS 2.2 logging sink benchmark project ID | `string` | `""` | no |
| <a name="input_env"></a> [env](#input_env) | The environment suffix for example: `sb` (Sandbox), `nonprod` (Non-Production), `prod` (Production) | `string` | `"sb"` | no |
| <a name="input_labels"></a> [labels](#input_labels) | A set of key/value label pairs to assign to the project | `map(string)` | `{}` | no |
| <a name="input_prefix"></a> [prefix](#input_prefix) | The team prefix for example: `ops` (Operations), `devops` (DevOps), `sec` (Security) | `string` | `"test"` | no |
| <a name="input_random_project_id"></a> [random_project_id](#input_random_project_id) | If true, a random hex value with a prefix of tf will be added to the `project_id` | `bool` | `true` | no |

### Outputs

| Name | Description |
|------|-------------|
| <a name="output_cis_2_2_logging_sink_project_id"></a> [cis_2_2_logging_sink_project_id](#output_cis_2_2_logging_sink_project_id) | The CIS 2.2 logging sink benchmark project ID |
| <a name="output_project_id"></a> [project_id](#output_project_id) | The project ID |
| <a name="output_project_number"></a> [project_number](#output_project_number) | The project number |
| <a name="output_unique_writer_identity"></a> [unique_writer_identity](#output_unique_writer_identity) | The unique identity associated with this sink |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Module Development

See the documentation for setting up a local development environment [here](https://docs.osinfra.io).

Tools in use:

- [checkov](https://github.com/bridgecrewio/checkov)
- [chef-inspec](https://github.com/inspec/inspec)
- [infracost](https://github.com/infracost/infracost)
- [inspec-gcp](https://github.com/inspec/inspec-gcp)
- [kitchen-terraform](https://github.com/newcontext-oss/kitchen-terraform)
- [pre-commit](https://github.com/pre-commit/pre-commit)
- [pre-commit-terraform](https://github.com/antonbabenko/pre-commit-terraform)
- [terraform-docs](https://github.com/terraform-docs/terraform-docs)

### Tests

```none
bundle exec kitchen converge
bundle exec kitchen verify
bundle exec kitchen destroy
```
