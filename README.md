# <img align="left" width="45" height="45" src="https://user-images.githubusercontent.com/1610100/195462632-f70a64d6-7811-4da3-aa82-c65cbbb74754.png"> Google Cloud Platform - Project OpenTofu Module

**[GitHub Actions](https://github.com/osinfra-io/terraform-google-project/actions):**

[![OpenTofu Tests](https://github.com/osinfra-io/terraform-google-project/actions/workflows/test.yml/badge.svg)](https://github.com/osinfra-io/terraform-google-project/actions/workflows/test.yml) [![Dependabot](https://github.com/osinfra-io/terraform-google-project/actions/workflows/dependabot.yml/badge.svg)](https://github.com/osinfra-io/terraform-google-project/actions/workflows/dependabot.yml)

**[Infracost](https://www.infracost.io):**

[![infracost](https://img.shields.io/endpoint?url=https://dashboard.api.infracost.io/shields/json/cbeecfe3-576f-4553-984c-e451a575ee47/repos/f8112db9-d028-45e6-86f5-c35c48a7c0b8/branch/43abfb4e-f8de-4d81-b98d-de0438843e47)](https://dashboard.infracost.io/org/osinfra-io/repos/f8112db9-d028-45e6-86f5-c35c48a7c0b8?tab=settings)

💵 Monthly estimates based on Infracost baseline costs.

## Repository Description

OpenTofu **example** module for a Google Cloud Platform project.

> [!NOTE]
> We do not recommend consuming this module like you might a [public module](https://search.opentofu.org/browse/modules). It is a baseline, something you can fork, potentially maintain, and modify to fit your organization's needs. Using public modules vs. writing your own has various [drivers and trade-offs](https://docs.osinfra.io/fundamentals/architecture-decision-records/adr-0003) that your organization should evaluate.

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

To avoid slowing down stream-aligned teams, we want to open up the possibility for contributions. The Open Source Infrastructure (as Code) model allows team members external to the platform team to contribute with only a slight increase in cognitive load. This section is for developers who want to contribute to this repository, describing the tools used, the skills, and the knowledge required, along with OpenTofu documentation.

See the documentation for setting up a local development environment [here](https://docs.osinfra.io/fundamentals/development-setup).

### 🛠️ Tools

- [infracost](https://github.com/infracost/infracost)
- [pre-commit](https://github.com/pre-commit/pre-commit)
- [osinfra-pre-commit-hooks](https://github.com/osinfra-io/pre-commit-hooks)

### 📋 Skills and Knowledge

Links to documentation and other resources required to develop and iterate in this repository successfully.

- [apis](https://cloud.google.com/apis/docs/overview)
- [audit logs](https://cloud.google.com/logging/docs/audit)
- [logging metrics](https://cloud.google.com/logging/docs/logs-based-metrics)
- [logging routing](https://cloud.google.com/logging/docs/routing/overview)
- [monitoring alerts](https://cloud.google.com/monitoring/alerts)
- [project](https://cloud.google.com/resource-manager/docs/creating-managing-projects)

### 🔍 Tests

All tests are [mocked](https://opentofu.org/docs/cli/commands/test/#the-mock_provider-blocks) allowing us to test the module without creating infrastructure or requiring credentials. The trade-offs are acceptable in favor of speed and simplicity. In an OpenTofu test, a mocked provider or resource will generate fake data for all computed attributes that would normally be provided by the underlying provider APIs.

```none
tofu init
```

```none
tofu test
```

## 📓 OpenTofu Documentation

> A child module automatically inherits default (un-aliased) provider configurations from its parent. The provider versions below are informational only and do **not** need to align with the provider configurations from its parent.
