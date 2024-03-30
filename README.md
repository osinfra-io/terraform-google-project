# <img align="left" width="45" height="45" src="https://user-images.githubusercontent.com/1610100/195462632-f70a64d6-7811-4da3-aa82-c65cbbb74754.png"> Google Cloud Platform - Project Terraform Module

**[GitHub Actions](https://github.com/osinfra-io/terraform-google-project/actions):**

[![Kitchen Tests](https://github.com/osinfra-io/terraform-google-project/actions/workflows/kitchen.yml/badge.svg)](https://github.com/osinfra-io/terraform-google-project/actions/workflows/kitchen.yml) [![CodeQL](https://github.com/osinfra-io/terraform-google-project/actions/workflows/github-code-scanning/codeql/badge.svg)](https://github.com/osinfra-io/terraform-google-project/actions/workflows/github-code-scanning/codeql) [![Dependabot](https://github.com/osinfra-io/terraform-google-project/actions/workflows/dependabot.yml/badge.svg)](https://github.com/osinfra-io/terraform-google-project/actions/workflows/dependabot.yml)

**[Infracost](https://www.infracost.io):**

[![infracost](https://img.shields.io/endpoint?label=default_project&url=https://dashboard.api.infracost.io/shields/json/cbeecfe3-576f-4553-984c-e451a575ee47/repos/f8112db9-d028-45e6-86f5-c35c48a7c0b8/branch/43abfb4e-f8de-4d81-b98d-de0438843e47/default_project)](https://dashboard.infracost.io/org/osinfra-io/repos/f8112db9-d028-45e6-86f5-c35c48a7c0b8?tab=settings) [![infracost](https://img.shields.io/endpoint?label=logging_project&url=https://dashboard.api.infracost.io/shields/json/cbeecfe3-576f-4553-984c-e451a575ee47/repos/f8112db9-d028-45e6-86f5-c35c48a7c0b8/branch/43abfb4e-f8de-4d81-b98d-de0438843e47/logging_project)](https://dashboard.infracost.io/org/osinfra-io/repos/f8112db9-d028-45e6-86f5-c35c48a7c0b8?tab=settings)

💵 Monthly estimates based on Infracost baseline costs.

## Repository Description

Terraform **example** module for a Google Cloud Platform project.

> [!NOTE]
> We do not recommend consuming this module like you might a [public module](https://registry.terraform.io/browse/modules). It is a baseline, something you can fork, potentially maintain, and modify to fit your organization's needs. Using public modules vs. writing your own has various [drivers and trade-offs](https://docs.osinfra.io/fundamentals/architecture-decision-records/adr-0003) that your organization should evaluate.

## 🔩 Usage

> [!TIP]
> You can check the [test/fixtures](test/fixtures/) directory for example configurations. These fixtures set up the system for testing by providing all the necessary initial code, thus creating good examples to base your configurations.

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

- [infracost](https://github.com/infracost/infracost)
- [inspec](https://github.com/inspec/inspec)
- [kitchen-terraform](https://github.com/newcontext-oss/kitchen-terraform)
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

You'll need to be a member of the [platform-contributors](https://groups.google.com/a/osinfra.io/g/platform-contributors) Google Group to run the tests. This group manages access to the resource hierarchy's `Testing/Sandbox` folder. You can request access to this group by opening an issue [here](https://github.com/osinfra-io/google-cloud-hierarchy/issues/new?assignees=&labels=enhancement&projects=&template=add-update-identity-group.yml&title=Add+or+update+identity+group).

```none
bundle install
```

```none
bundle exec kitchen converge
```

```none
bundle exec kitchen verify
```

```none
bundle exec kitchen destroy
```

## 📓 Terraform Documentation

- [global](global/README.md)
