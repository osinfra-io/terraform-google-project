project_id = input('project_id')

control 'logging_sync' do
  title 'Logging Sync'

  # Logging Project Sink Resource
  # https://docs.chef.io/inspec/resources/google_logging_project_sink

  describe google_logging_project_sink(project: project_id, name: 'cis-2-2-logging-sink') do
    it { should exist }
    destination = "logging.googleapis.com/projects/#{project_id}"
    its('destination') { should eq "#{destination}/locations/global/buckets/cis-2-2-logging-sink" }
  end
end
