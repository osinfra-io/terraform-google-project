mock_provider "google" {
  mock_resource "google_logging_project_sink" {
    defaults = {
      writer_identity = "serviceAccount:mock-cis-2-2-logging-sink@mock.iam.gserviceaccount.com"
    }
  }
}

run "default" {
  command = apply

  module {
    source = "./tests/fixtures/default"
  }

  variables {
    cis_2_2_logging_sink_project_id = "mock-logging-sink-project"
  }
}

run "logging" {
  command = apply

  module {
    source = "./tests/fixtures/logging"
  }
}

variables {
  environment = "mock"
}
