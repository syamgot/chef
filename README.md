# chef

my chef for centos

## chef-solo

	cd /path/to/chef
	chef-solo -c solo.rb -j ./localhost.json

## vagrant

	# -*- mode: ruby -*-
	# vi: set ft=ruby :
	
	Vagrant.configure(2) do |config|
		config.vm.box = "chef/centos-6.6"
		config.omnibus.chef_version = :latest
		config.vm.provision :chef_solo do |chef|
			chef.cookbooks_path = "../chef/cookbooks"
			chef.json = JSON.parse(File.read('../chef/localhost.json'))
		end
	end

