#
# Cookbook Name:: eccube
# Recipe:: default
#
# Copyright 2014, OpsDeliver
#
# All rights reserved - Do Not Redistribute
#
  #{node['eccube']['database']['_USER_PASSWORD']}

mysql_connection_info = { :host => 'localhost', :username => 'root', :password => node['mysql']['server_root_password'] }

mysql_database "#{node['eccube']['database']['_DATABASE_NAME']}" do 
  connection mysql_connection_info
  action :create
end

mysql_database_user "#{node['eccube']['database']['_USER_NAME']}" do
  connection mysql_connection_info
  password "#{node['eccube']['database']['_USER_PASSWORD']}"
  action :create
end

mysql_database_user "#{node['eccube']['database']['_USER_NAME']}" do
  connection mysql_connection_info
  password "#{node['eccube']['database']['_USER_PASSWORD']}"
  database_name "#{node['eccube']['database']['_DATABASE_NAME']}"
  host '%'
  privileges [:all]
  action :grant
end
