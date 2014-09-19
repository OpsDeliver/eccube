#
# Cookbook Name:: eccube
# Recipe:: default
#
# Copyright 2014, OpsDeliver
#
# All rights reserved - Do Not Redistribute
#

postgresql_connection_info = { :host => 'localhost', :port => '5432', :username => 'postgres', :password => node['postgresql']['password']['postgres'] }

postgresql_database "#{node['eccube']['database']['_DATABASE_NAME']}" do 
  connection postgresql_connection_info
  action :create
end

postgresql_database_user "#{node['eccube']['database']['_USER_NAME']}" do
  connection postgresql_connection_info
  password "#{node['eccube']['database']['_USER_PASSWORD']}"
  action :create
end

postgresql_database_user "#{node['eccube']['database']['_USER_NAME']}" do
  connection postgresql_connection_info
  password "#{node['eccube']['database']['_USER_PASSWORD']}"
  database_name "#{node['eccube']['database']['_DATABASE_NAME']}"
  host '%'
  privileges [:all]
  action :grant
end
