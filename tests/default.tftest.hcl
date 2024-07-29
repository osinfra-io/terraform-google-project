mock_provider "google" {
  mock_resource "google_logging_project_sink" {
    defaults = {
      writer_identity = "serviceAccount:cis-2-2-logging-sink@mock.iam.gserviceaccount.com"
    }
  }
}

run "default" {
  command = apply

  module {
    source = "./tests/fixtures/default"
  }
}

run "logging" {
  command = apply

  module {
    source = "./tests/fixtures/logging"
  }
}
