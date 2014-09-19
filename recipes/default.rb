#
# Cookbook Name:: eccube
# Recipe:: default
#
# Copyright 2014, OpsDeliver
#
# All rights reserved - Do Not Redistribute
#
%w{
  php-mbstring unzip wget
}.each do |package_name|
    package package_name do
    action :install
  end
end

script "copy_files" do
  interpreter "bash"
  user "root"
  cwd "/tmp"
  code <<-EOH
    wget #{node['eccube']['url']}#{node['eccube']['filename']}
    unzip #{node['eccube']['filename']}
    cp -a #{node['eccube']['dirname']}/data #{node['eccube']['dirname']}/eccube
    cp -a #{node['eccube']['dirname']}/eccube /var/www/
  EOH
end

template "/var/www/eccube/define.php" do
  source "define.php.erb"
  owner "root"
  group "root"
  mode 0666
end
