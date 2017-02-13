#
# Cookbook Name:: test-kitchen-demo
# Recipe:: default
#
# Copyright (c) 2017 The Authors, All Rights Reserved.

package 'httpd' do
  action :install
end

# Grab a list of websites that should exist (the list of databag items)
websites=data_bag('websites')

# Iterate through the list grabbing the items from the server
websites.each do |website_name|
  website = data_bag_item('websites',website_name)

  directory "#{website['path']}" do
    owner 'apache'
    group 'apache'
    mode '0755'
    recursive true
    action :create
  end

  template "#{website['path']}/index.html" do
    source 'index.html.erb'
    owner 'apache'
    group 'apache'
    mode  '0755'
  end

end #Of the website loop
