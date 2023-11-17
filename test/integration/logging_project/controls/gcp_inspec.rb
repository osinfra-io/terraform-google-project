# Chef InSpec
# https://www.chef.io/inspec
cis_2_2_logging_sink_service_account = input('cis_2_2_logging_sink_service_account')
project_id = input('project_id')

control 'kms_crypto_key' do
  title 'KMS Crypto Key'

  # KMS Crypto Key Resource
  # https://docs.chef.io/inspec/resources/google_kms_crypto_key

  describe google_kms_crypto_key(project: project_id, location: 'us',
                                 key_ring_name: 'default',
                                 name: 'cis-2-2-logging-sink') do
    it { should exist }
  end
end

control 'kms_crypto_key_iam_binding' do
  title 'KMS Crypto Key IAM Binding'

  # KMS Crypto Key IAM Binding Resource
  # https://docs.chef.io/inspec/resources/google_kms_crypto_key_iam_binding

  describe google_kms_crypto_key_iam_binding(project: project_id, location: 'us',
                                             key_ring_name: 'default',
                                             crypto_key_name: 'cis-2-2-logging-sink',
                                             role: 'roles/cloudkms.cryptoKeyEncrypterDecrypter') do
    it { should exist }
    its('members') do
      should include "serviceAccount:#{cis_2_2_logging_sink_service_account}"
    end
  end
end

control 'logging_project_sync' do
  title 'Logging Project Sync'

  # Logging Project Sink Resource
  # https://docs.chef.io/inspec/resources/google_logging_project_sink

  describe google_logging_project_sink(project: project_id, name: 'cis-2-2-logging-sink') do
    it { should exist }
    destination = "logging.googleapis.com/projects/#{project_id}"
    its('destination') { should eq "#{destination}/locations/us/buckets/cis-2-2-logging-sink" }
  end
end
