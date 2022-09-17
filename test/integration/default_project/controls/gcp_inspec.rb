# Chef InSpec
# https://www.chef.io/inspec

# Since this is the default test, we want to test as much as possible here and not be redundant in the other tests.

project_id = input('project_id')

control 'compute_project_info' do
  title 'Compute Project Info'

  # Compute Project Info Resource
  # https://docs.chef.io/inspec/resources/google_compute_project_info

  describe google_compute_project_info(project: project_id) do
    it { should exist }
  end
end

control 'logging_sync' do
  title 'Logging Sync'

  # Logging Project Sink Resource
  # https://docs.chef.io/inspec/resources/google_logging_project_sink

  describe google_logging_project_sink(project: project_id, name: 'cis-2-2-logging-sink') do
    it { should exist }
    destination = 'logging.googleapis.com/projects/devops-testing-tf67de-sb'
    its('destination') { should eq "#{destination}/locations/global/buckets/cis-2-2-logging-sink" }
  end
end

control 'project_audit_config' do
  title 'Project Audit Config'

  # Project Logging Audit Config Resource
  # https://docs.chef.io/inspec/resources/google_project_logging_audit_config

  describe google_project_logging_audit_config(project: project_id) do
    it { should exist }
    its('default_types') { should include 'ADMIN_READ' }
    its('default_types') { should include 'DATA_READ' }
    its('default_types') { should include 'DATA_WRITE' }
  end
end
