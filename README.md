# <img align="left" width="45" height="45" src="https://user-images.githubusercontent.com/1610100/195462632-f70a64d6-7811-4da3-aa82-c65cbbb74754.png"> Google Cloud Platform - Project Terraform Module

**[GitHub Actions](https://github.com/osinfra-io/terraform-google-project/actions):**

[![Kitchen Tests](https://github.com/osinfra-io/terraform-google-project/actions/workflows/kitchen.yml/badge.svg)](https://github.com/osinfra-io/terraform-google-project/actions/workflows/kitchen.yml) [![Dependabot](https://github.com/osinfra-io/terraform-google-project/actions/workflows/dependabot.yml/badge.svg)](https://github.com/osinfra-io/terraform-google-project/actions/workflows/dependabot.yml)

**[Infracost](https://www.infracost.io):**

[![infracost](https://img.shields.io/endpoint?label=Default%20Project&url=https://dashboard.api.infracost.io/shields/json/cbeecfe3-576f-4553-984c-e451a575ee47/repos/f8112db9-d028-45e6-86f5-c35c48a7c0b8/branch/43abfb4e-f8de-4d81-b98d-de0438843e47/terraform-google-project%2520-%2520Default%2520Project)](https://dashboard.infracost.io/org/osinfra-io/repos/f8112db9-d028-45e6-86f5-c35c48a7c0b8) [![infracost](https://img.shields.io/endpoint?label=Logging%20Project&url=https://dashboard.api.infracost.io/shields/json/cbeecfe3-576f-4553-984c-e451a575ee47/repos/f8112db9-d028-45e6-86f5-c35c48a7c0b8/branch/43abfb4e-f8de-4d81-b98d-de0438843e47/terraform-google-project%2520-%2520Logging%2520Project)](https://dashboard.infracost.io/org/osinfra-io/repos/f8112db9-d028-45e6-86f5-c35c48a7c0b8)

Monthly cost estimates for this module based off these usage values:

- [Default Project](test/fixtures/default_project/infracost-usage.yml)
- [Logging Project](test/fixtures/logging_project/infracost-usage.yml)

## Module Description

Terraform **example** module for a Google Cloud Platform project.

*We do not recommend consuming this module like you might a [public module](https://registry.terraform.io/browse/modules). Its purpose is to be a baseline, something you can fork and potentially maintain on your own and modify to fit your organization's needs. Using public modules vs. writing your own have various [drivers and trade-offs](https://github.com/orgs/osinfra-io/discussions/3) that your organization should evaluate.*

## Usage

You can check the [test/fixtures](test/fixtures/) directory for example configurations. These fixtures set up the system for the testing process by providing it with all the necessary code to initialize it, thus creating good examples to base your configurations on.

Here is an example of a basic configuration:

```hcl
module "project" {
  source = "github.com/osinfra-io/terraform-google-project//global?ref=v0.0.0"

  billing_id                      = "555-555-555-555"
  cis_2_2_logging_sink_project_id = "example-logging-project"
  cost_center                     = "x000"
  description                     = "example"
  environment                     = "sb"
  folder_id                       = "1111111111111"

  labels = {
    key = "value",
  }

  prefix = "team"

  services = [
    "compute.googleapis.com"
  ]
}
```

## Project Names

Project names include a prefix, a description as well as
an environment, for example:

```none
team-example-tf2a-sb
```

The `tf2a` is a hex output from the random resource. We do not want to duplicate project IDs because project IDs are globally unique. Also, when you delete a project, it goes into a pending deletion state for 30 days, where you can't reuse the project ID. If you want to exclude this from your project name, you can use the variable: `random_project_id = false`

## <img align="left" width="35" height="35" src="https://user-images.githubusercontent.com/1610100/209029142-410349b7-4b22-40a9-9d4d-729f07e2b4a2.png"> Development

Open Source Infrastructure (as code) is a development model for infrastructure that focuses on open collaboration applying relative lessons learned from software development practices that organizations can use internally at scale. - [Open Source Infrastructure (as Code)](https://www.osinfra.io)

To avoid slowing down [stream-aligned](https://teamtopologies.com/key-concepts) teams, we want to open up the possibility for contributions. The Open Source Infrastructure (as Code) model allows team members external to the platform team to contribute with only a slight increase in cognitive load. This section is for developers who want to contribute to this repository describing the tools used, the skills, and the knowledge required, along with Terraform documentation.

See the documentation for setting up a local development environment [here](https://docs.osinfra.io/development-setup).

### Tools

- [infracost](https://github.com/infracost/infracost)
- [inspec](https://github.com/inspec/inspec)
- [kitchen-terraform](https://github.com/newcontext-oss/kitchen-terraform)
- [pre-commit](https://github.com/pre-commit/pre-commit)
- [pre-commit-terraform](https://github.com/antonbabenko/pre-commit-terraform)
- [terraform-docs](https://github.com/terraform-docs/terraform-docs)

### Skills and Knowledge

Links to documentation and other resources required to develop and iterate in this repository successfully.

- [apis](https://cloud.google.com/apis/docs/overview)
- [audit logs](https://cloud.google.com/logging/docs/audit)
- [logging routing](https://cloud.google.com/logging/docs/routing/overview)
- [project](https://cloud.google.com/resource-manager/docs/creating-managing-projects)

### Tests

```none
bundle exec kitchen converge
bundle exec kitchen verify
bundle exec kitchen destroy
```

### Terraform Documentation

- [Global Infrastructure](global/README.md)
