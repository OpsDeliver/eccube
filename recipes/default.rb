#
# Cookbook Name:: eccube
# Recipe:: default
#
# Copyright 2014, OpsDeliver
#
# All rights reserved - Do Not Redistribute
#

%w{
unzip wget
}.each do |package_name|
    package package_name do
    action :install
  end
end

package "php-mbstring" do
  case node["platform_family"]
  when 'rhel', 'fedora', 'arch', 'freebsd', 'suse'
    package_name "php-mbstring"
  when "debian", "ubuntu"
    package_name "libapache2-mod-php5"
  end
  action :install
end

script "copy_files" do
  interpreter "bash"
  user "root"
  cwd "/tmp"
  code <<-EOH
    wget #{node['eccube']['url']}#{node['eccube']['filename']}
    unzip #{node['eccube']['filename']}
    cp -a #{node['eccube']['dirname']}/data #{node['eccube']['dirname']}/html
    cp -a #{node['eccube']['dirname']}/html /var/www/
    rm -f /var/www/html/index.html
  EOH
end

template "/var/www/html/define.php" do
  source "define.php.erb"
  owner "root"
  group "root"
  mode 0666
end
