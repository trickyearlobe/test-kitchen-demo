#
# Cookbook Name:: test-kitchen-demo
# Spec:: default
#
# Copyright (c) 2017 The Authors, All Rights Reserved.

require 'spec_helper'

describe 'test-kitchen-demo::default' do
  context 'When all attributes are default it' do

    let(:chef_run) do
      runner = ChefSpec::SoloRunner.new
      runner.converge(described_recipe)
    end

    # Supply an example data bag to check the logic in the cookbook
    before do
      stub_data_bag('websites').and_return(["website1","website2"])
      stub_data_bag_item('websites','website1').and_return({id:'website1',path:'/var/www/html/website1'})
      stub_data_bag_item('websites','website2').and_return({id:'website1',path:'/var/www/html/website2'})
    end

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end

    it 'starts apache' do
      expect(chef_run).to start_service('httpd')
    end

    it 'starts apache at bootup' do
      expect(chef_run).to enable_service('httpd')
    end


    it 'creates the website directories' do
      expect(chef_run).to create_directory('/var/www/html/website1')
      expect(chef_run).to create_directory('/var/www/html/website2')
    end

    it 'creates the correct index.html' do
      expect(chef_run).to render_file('/var/www/html/website1/index.html').with_content('It works')
      expect(chef_run).to render_file('/var/www/html/website2/index.html').with_content('It works')
    end


  end
end
