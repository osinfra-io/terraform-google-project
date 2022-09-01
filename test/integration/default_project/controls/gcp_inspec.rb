cis_2_2_location = input('cis_2_2_location')
project_id = input('project_id')
project_number = input('project_number')

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

  describe google_logging_project_sink(project: project_id, name: 'cis-gcp-2.1-logging-sink') do
    it { should exist }
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
