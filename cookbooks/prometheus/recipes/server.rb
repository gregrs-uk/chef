#
# Cookbook:: prometheus
# Recipe:: server
#
# Copyright:: 2020, OpenStreetMap Foundation
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     https://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

package "prometheus"

clients = search(:node, "recipes:prometheus\\:\\:default").sort_by(&:name)

template "/etc/prometheus/prometheus.yml" do
  source "prometheus.yml.erb"
  owner "root"
  group "root"
  mode "644"
  variables :clients => clients
end

service "prometheus" do
  action [:enable, :start]
  subscribes :reload, "template[/etc/prometheus/prometheus.yml]"
end
