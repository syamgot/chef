#
# Cookbook Name:: core
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#




# stop iptables
service "iptables" do
	action [:stop, :disable]
end


# 
%w{
	vim
	gcc
	make
	wget
	telnet
	readline-devel
	ncurses-devel
	gdbm-devel
	openssl-devel
	zlib-devel
	libyaml-devel
}.each do |p|
	package p do
		action :install
	end
end

