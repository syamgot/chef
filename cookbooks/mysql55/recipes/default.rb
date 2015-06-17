#
# Cookbook Name:: mysql55
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#


# remove
%w{
	mysql
	mysql-server
}.each do |p|
	package p do
		action :remove
	end
end


# epel repository
remote_file "/tmp/#{node['epel']['file_name']}" do
  source "#{node['epel']['remote_uri']}"
  not_if { ::File.exists?("/tmp/#{node['epel']['file_name']}") }
end
package node['epel']['file_name'] do
  action :install
  provider Chef::Provider::Package::Rpm
  source "/tmp/#{node['epel']['file_name']}"
end
# remi repository
remote_file "/tmp/#{node['remi']['file_name']}" do
  source "#{node['remi']['remote_uri']}"
  not_if { ::File.exists?("/tmp/#{node['remi']['file_name']}") }
end
package node['remi']['file_name'] do
  action :install
  provider Chef::Provider::Package::Rpm
  source "/tmp/#{node['remi']['file_name']}"
end


# install
%w{
	mysql
	mysql-server
}.each do |p|
	package p do
		action :install
		options "--enablerepo=remi"
	end
end


# service
service 'mysqld' do
  supports :status => true, :restart => true, :reload => true
  action [ :enable , :start ]
end


# my.cnf
template 'my.cnf' do
  path '/etc/my.cnf'
  source 'my.cnf.erb'
  owner 'root'
  group 'root'
  mode 644
  notifies :restart, "service[mysqld]"
end


# log files
mysql_log_dir = '/var/log/mysql'
directory mysql_log_dir do
  owner 'root'
  group 'root'
  mode  '0755'
  action :create
end
 
# touch log files
%w[
  error
  slow
  query
].each do |log_name|
  bash "create_#{log_name}_log" do
    log_file = "#{mysql_log_dir}/#{log_name}.log"
    code <<-EOC
      touch #{log_file}
    EOC
    creates log_file
  end
end


