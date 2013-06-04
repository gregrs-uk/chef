#
# Cookbook Name:: git
# Recipe:: server
#
# Copyright 2011, OpenStreetMap Foundation
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

include_recipe "apache"
include_recipe "networking"

package "gitweb"

apache_module "rewrite"

git_directory = node[:git][:directory]

directory git_directory do
  owner "git"
  group "git"
  mode 02775
end

template "/etc/gitweb.conf" do
  source "gitweb.conf.erb"
  owner "root"
  group "root"
  mode 0644
end

apache_site node[:git][:host] do
  template "apache.erb"
  directory git_directory
end

template "#{git_directory}/robots.txt" do
  source "robots.txt.erb"
  owner "root"
  group "root"
  mode 0644
end

firewall_rule "accept-git" do
  action :accept
  source "net"
  dest "fw"
  proto "tcp:syn"
  dest_ports "git"
  source_ports "1024:"
end

Dir.new(git_directory).select { |name| name =~ /\.git$/ }.each do |repository|
  template "#{git_directory}/#{repository}/hooks/post-update" do
    source "post-update.erb"
    owner "root"
    group "git"
    mode 0755
  end

  if repository != "dns.git"
    template "#{git_directory}/#{repository}/hooks/post-receive" do
      source "post-receive.erb"
      owner "root"
      group "git"
      mode 0755
      variables :repository => "#{git_directory}/#{repository}"
    end
  end
end
