#
# Cookbook Name:: dotfiles
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#




#
package 'git' do 
	action :install
end

#
# git ''+node['vagrant']['user']+'/dotfiles' do 
# git "/home/#{node['vagrant']['user']}/dotfiles" do
git '/home/vagrant/dotfiles' do
	repository 'https://github.com/syamgot/dotfiles'
	action :checkout
	notifies :run, 'bash[install dotfiles]', :immediately
end

#
bash 'install dotfiles' do
	environment 'HOME' => '/home/vagrant'
	code <<-EOS
chown -R vagrant:vagrant $HOME/dotfiles 
EOS
end

