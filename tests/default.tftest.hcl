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
