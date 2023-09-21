# Chef InSpec
# https://www.chef.io/inspec

# Since this is the default test, we want to test as much as possible here and not be redundant in the other tests.

cis_2_2_logging_sink_project_id = input('cis_2_2_logging_sink_project_id')
project_id = input('project_id')
unique_writer_identity = input('unique_writer_identity')

metrics = [
  { name: 'cis-2-4',
    filter: '(protoPayload.serviceName="cloudresourcemanager.googleapis.com") AND (ProjectOwnership OR projectOwnerInvitee) OR (protoPayload.serviceData.policyDelta.bindingDeltas.action="REMOVE" AND protoPayload.serviceData.policyDelta.bindingDeltas.role="roles/owner") OR (protoPayload.serviceData.policyDelta.bindingDeltas.action="ADD" AND protoPayload.serviceData.policyDelta.bindingDeltas.role="roles/owner")' },
  { name: 'cis-2-5',
    filter: 'protoPayload.methodName="SetIamPolicy" AND protoPayload.serviceData.policyDelta.auditConfigDeltas:*' },
  { name: 'cis-2-6',
    filter: 'resource.type="iam_role" AND (protoPayload.methodName = "google.iam.admin.v1.CreateRole" OR protoPayload.methodName="google.iam.admin.v1.DeleteRole" OR protoPayload.methodName="google.iam.admin.v1.UpdateRole")' },
  { name: 'cis-2-7',
    filter: 'resource.type="gce_firewall_rule" AND (protoPayload.methodName:"compute.firewalls.patch" OR protoPayload.methodName:"compute.firewalls.insert" OR protoPayload.methodName:"compute.firewalls.delete")' },
  { name: 'cis-2-8',
    filter: 'resource.type="gce_route" AND (protoPayload.methodName:"compute.routes.delete" OR protoPayload.methodName:"compute.routes.insert")' },
  { name: 'cis-2-9',
    filter: 'resource.type="gce_network" AND (protoPayload.methodName:"compute.networks.insert" OR protoPayload.methodName:"compute.networks.patch" OR protoPayload.methodName:"compute.networks.delete" OR protoPayload.methodName:"compute.networks.removePeering" OR protoPayload.methodName:"compute.networks.addPeering")' },
  { name: 'cis-2-10',
    filter: 'resource.type="gcs_bucket" AND protoPayload.methodName="storage.setIamPermissions"' },
  { name: 'cis-2-11', filter: 'protoPayload.methodName="cloudsql.instances.update"' }
]

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
    destination = 'logging.googleapis.com/projects/plt-lz-audit01-tf6e-sb'
    its('destination') { should eq "#{destination}/locations/global/buckets/cis-2-2-logging-sink" }
  end
end

# TODO: #57 Add tests for `google_project_alert_policy` resource
# https://docs.chef.io/inspec/resources/google_project_alert_policy
# https://docs.chef.io/inspec/resources/google_project_alert_policy_condition

control 'project_metric' do
  title 'Project Metric'

  # Project Metric Resource
  # https://docs.chef.io/inspec/resources/google_project_metric

  metrics.each do |metric|
    describe google_project_metric(project: project_id, name: metric[:name]) do
      it { should exist }
      its('filter') { should eq metric[:filter] }
    end
  end
end

control 'project_iam_binding' do
  title 'Project IAM Binding'

  # Project IAM Binding Resource
  # https://docs.chef.io/inspec/resources/google_project_iam_binding

  describe google_project_iam_binding(project: cis_2_2_logging_sink_project_id,
                                      role: 'roles/logging.bucketWriter') do
    it { should exist }
    its('members') { should include unique_writer_identity }
  end
end

control 'project_logging_audit_config' do
  title 'Project Logging Audit Config'

  # Project Logging Audit Config Resource
  # https://docs.chef.io/inspec/resources/google_project_logging_audit_config

  describe google_project_logging_audit_config(project: project_id) do
    it { should exist }
    its('default_types') { should include 'ADMIN_READ' }
    its('default_types') { should include 'DATA_READ' }
    its('default_types') { should include 'DATA_WRITE' }
  end
end

control 'project_service' do
  title 'Project Service'

  # Project Service Resource
  # https://docs.chef.io/inspec/resources/google_project_service

  describe google_project_service(project: project_id, name: 'logging.googleapis.com') do
    it { should exist }
    its('state') { should eq 'ENABLED' }
  end
end
