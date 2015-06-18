#
# Cookbook Name:: httpd
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#


package 'httpd' do 
	action :install
end

service 'httpd' do
	supports :status => true, :restart => true, :reload => true
	action [:start, :enable]
end

template "httpd.conf" do
	path "/etc/httpd/conf/httpd.conf"
	source "httpd.conf.erb"
	mode 0644
	notifies :restart, 'service[httpd]'
end
