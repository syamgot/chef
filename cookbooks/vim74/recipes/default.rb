#
# Cookbook Name:: vim74
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#


#
package 'vim' do 
	action :remove
end


# 
%w{
  gcc
  python-devel
  lua-devel
  ncurses-devel
  perl-ExtUtils-Embed
}.each do |p|
	package p do
		action :install
	end
end


#
bash 'install' do 
	creates '/usr/local/bin/vim'
	user 'root'
	code <<-EOS
wget ftp://ftp.vim.org/pub/vim/unix/vim-7.4.tar.bz2 -P /tmp
tar xfj /tmp/vim-7.4.tar.bz2  -C /tmp
cd /tmp/vim74
./configure  --enable-multibyte  --with-features=huge  --enable-luainterp  --enable-perlinterp  --enable-pythoninterp  --with-python-config-dir=/usr/lib64/python2.6/config  --enable-rubyinterp  --with-ruby-command=/usr/bin/ruby  --prefix=/usr/local
make && make install
EOS
end


