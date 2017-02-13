# # encoding: utf-8

# Inspec test for recipe test-kitchen-demo::default

# The Inspec reference, with examples and extensive documentation, can be
# found at https://docs.chef.io/inspec_reference.html

unless os.windows?
  describe user('apache') do
    it { should exist }
  end
end

describe service('httpd') do
  it { should be_running }
end

describe file('/var/www/html/chef.io/index.html') do
  it { should exist }
  it { should be_owned_by('apache') }
  its('content') { should match "It works" }
end

describe port(80) do
  it { should be_listening }
end

# NOTE: The HTTP resource doesn't currently execute on the target... it runs locally
#       To make it work remotely we set up port forwarding in .kitchen.yml
#       When we run it through chef:automate:workflow we need a better strategy
#       We may want to submit a patch for Inspec
describe http('http://localhost:8080/chef.io/') do
  its('status') { should eq 200 }
  its('body') { should match 'It works' }
end
