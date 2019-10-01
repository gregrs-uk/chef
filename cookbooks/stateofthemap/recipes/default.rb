#
# Cookbook:: stateofthemap
# Recipe:: default
#
# Copyright:: 2013, OpenStreetMap Foundation
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

include_recipe "wordpress"

passwords = data_bag_item("stateofthemap", "passwords")

git "/srv/stateofthemap.org" do
  action :sync
  repository "https://git.openstreetmap.org/public/stateofthemap.git"
  revision "chooser"
  user "root"
  group "root"
end

ssl_certificate "stateofthemap.org" do
  domains ["stateofthemap.org", "www.stateofthemap.org",
           "stateofthemap.com", "www.stateofthemap.com",
           "sotm.org", "www.sotm.org"]
  notifies :reload, "service[apache2]"
end

apache_site "stateofthemap.org" do
  template "apache.erb"
  directory "/srv/stateofthemap.org"
end

directory "/srv/2007.stateofthemap.org" do
  owner "wordpress"
  group "wordpress"
  mode 0o755
end

wordpress_site "2007.stateofthemap.org" do
  aliases "2007.stateofthemap.com"
  directory "/srv/2007.stateofthemap.org/wp"
  database_name "sotm2007"
  database_user "sotm2007"
  database_password passwords["sotm2007"]
  database_prefix "wp_sotm_"
end

wordpress_theme "2007.stateofthemap.org-refreshwp-11" do
  theme "refreshwp-11"
  site "2007.stateofthemap.org"
  repository "https://git.openstreetmap.org/public/stateofthemap.git"
  revision "theme-2007"
end

wordpress_plugin "2007.stateofthemap.org-geopress" do
  plugin "geopress"
  site "2007.stateofthemap.org"
end

directory "/srv/2008.stateofthemap.org" do
  owner "wordpress"
  group "wordpress"
  mode 0o755
end

wordpress_site "2008.stateofthemap.org" do
  aliases "2008.stateofthemap.com"
  directory "/srv/2008.stateofthemap.org/wp"
  database_name "sotm2008"
  database_user "sotm2008"
  database_password passwords["sotm2008"]
  database_prefix "wp_sotm08_"
end

wordpress_theme "2008.stateofthemap.org-refreshwp-11" do
  theme "refreshwp-11"
  site "2008.stateofthemap.org"
  repository "https://git.openstreetmap.org/public/stateofthemap.git"
  revision "theme-2008"
end

wordpress_plugin "2008.stateofthemap.org-geopress" do
  plugin "geopress"
  site "2008.stateofthemap.org"
end

directory "/srv/2009.stateofthemap.org" do
  owner "wordpress"
  group "wordpress"
  mode 0o755
end

git "/srv/2009.stateofthemap.org" do
  action :sync
  repository "https://git.openstreetmap.org/public/stateofthemap.git"
  revision "resources-2009"
  user "wordpress"
  group "wordpress"
end

wordpress_site "2009.stateofthemap.org" do
  aliases "2009.stateofthemap.com"
  directory "/srv/2009.stateofthemap.org/wp"
  database_name "sotm2009"
  database_user "sotm2009"
  database_password passwords["sotm2009"]
  urls "/register" => "/srv/2009.stateofthemap.org/register",
       "/register-pro-user" => "/srv/2009.stateofthemap.org/register-pro-user",
       "/podcasts" => "/srv/2009.stateofthemap.org/podcasts"
end

wordpress_theme "2009.stateofthemap.org-aerodrome" do
  theme "aerodrome"
  site "2009.stateofthemap.org"
  repository "https://git.openstreetmap.org/public/stateofthemap.git"
  revision "theme-2009"
end

wordpress_plugin "2009.stateofthemap.org-wp-sticky" do
  plugin "wp-sticky"
  site "2009.stateofthemap.org"
end

directory "/srv/2010.stateofthemap.org" do
  owner "wordpress"
  group "wordpress"
  mode 0o755
end

git "/srv/2010.stateofthemap.org" do
  action :sync
  repository "https://git.openstreetmap.org/public/stateofthemap.git"
  revision "resources-2010"
  user "wordpress"
  group "wordpress"
end

wordpress_site "2010.stateofthemap.org" do
  aliases "2010.stateofthemap.com"
  directory "/srv/2010.stateofthemap.org/wp"
  database_name "sotm2010"
  database_user "sotm2010"
  database_password passwords["sotm2010"]
  urls "/register" => "/srv/2010.stateofthemap.org/register"
end

wordpress_theme "2010.stateofthemap.org-aerodrome" do
  theme "aerodrome"
  site "2010.stateofthemap.org"
  repository "https://git.openstreetmap.org/public/stateofthemap.git"
  revision "theme-2010"
end

wordpress_plugin "2010.stateofthemap.org-sitepress-multilingual-cms" do
  plugin "sitepress-multilingual-cms"
  site "2010.stateofthemap.org"
  repository "https://git.openstreetmap.org/private/sitepress-multilingual-cms.git"
end

wordpress_plugin "2010.stateofthemap.org-wp-sticky" do
  plugin "wp-sticky"
  site "2010.stateofthemap.org"
end

directory "/srv/2011.stateofthemap.org" do
  owner "wordpress"
  group "wordpress"
  mode 0o755
end

git "/srv/2011.stateofthemap.org" do
  action :sync
  repository "https://git.openstreetmap.org/public/stateofthemap.git"
  revision "resources-2011"
  user "wordpress"
  group "wordpress"
end

wordpress_site "2011.stateofthemap.org" do
  aliases "2011.stateofthemap.com"
  directory "/srv/2011.stateofthemap.org/wp"
  database_name "sotm2011"
  database_user "sotm2011"
  database_password passwords["sotm2011"]
  urls "/register" => "/srv/2011.stateofthemap.org/register"
end

wordpress_theme "2011.stateofthemap.org-aerodrome" do
  theme "aerodrome"
  site "2011.stateofthemap.org"
  repository "https://git.openstreetmap.org/public/stateofthemap.git"
  revision "theme-2011"
end

wordpress_plugin "2011.stateofthemap.org-sitepress-multilingual-cms" do
  plugin "sitepress-multilingual-cms"
  site "2011.stateofthemap.org"
  repository "https://git.openstreetmap.org/private/sitepress-multilingual-cms.git"
end

wordpress_plugin "2011.stateofthemap.org-wp-sticky" do
  plugin "wp-sticky"
  site "2011.stateofthemap.org"
end

directory "/srv/2012.stateofthemap.org" do
  owner "wordpress"
  group "wordpress"
  mode 0o755
end

git "/srv/2012.stateofthemap.org" do
  action :sync
  repository "https://git.openstreetmap.org/public/stateofthemap.git"
  revision "resources-2012"
  user "wordpress"
  group "wordpress"
end

wordpress_site "2012.stateofthemap.org" do
  aliases "2012.stateofthemap.com"
  directory "/srv/2012.stateofthemap.org/wp"
  database_name "sotm2012"
  database_user "sotm2012"
  database_password passwords["sotm2012"]
  urls "/register" => "/srv/2012.stateofthemap.org/register"
end

wordpress_theme "2012.stateofthemap.org-aerodrome" do
  theme "aerodrome"
  site "2012.stateofthemap.org"
  repository "https://git.openstreetmap.org/public/stateofthemap.git"
  revision "theme-2012"
end

wordpress_plugin "2012.stateofthemap.org-leaflet-maps-marker" do
  plugin "leaflet-maps-marker"
  site "2012.stateofthemap.org"
end

wordpress_plugin "2012.stateofthemap.org-sitepress-multilingual-cms" do
  plugin "sitepress-multilingual-cms"
  site "2012.stateofthemap.org"
  repository "https://git.openstreetmap.org/private/sitepress-multilingual-cms.git"
end

wordpress_plugin "2012.stateofthemap.org-wp-sticky" do
  plugin "wp-sticky"
  site "2012.stateofthemap.org"
end

%w[2013].each do |year|
  git "/srv/#{year}.stateofthemap.org" do
    action :sync
    repository "https://git.openstreetmap.org/public/stateofthemap.git"
    revision "site-#{year}"
    user "root"
    group "root"
  end

  ssl_certificate "#{year}.stateofthemap.org" do
    domains ["#{year}.stateofthemap.org", "#{year}.stateofthemap.com"]
    notifies :reload, "service[apache2]"
  end

  apache_site "#{year}.stateofthemap.org" do
    template "apache.static.erb"
    directory "/srv/#{year}.stateofthemap.org"
    variables :year => year
  end
end

package %w[
  ruby
  ruby-dev
  zlib1g-dev
]

gem_package "jekyll"
gem_package "bundler" do
  version "1.17.3"
end

%w[2016 2017 2018 2019 2020].each do |year|
  git "/srv/#{year}.stateofthemap.org" do
    action :sync
    repository "git://github.com/openstreetmap/stateofthemap-#{year}.git"
    user "root"
    group "root"
    notifies :run, "execute[/srv/#{year}.stateofthemap.org]"
  end

  directory "/srv/#{year}.stateofthemap.org/_site" do
    mode 0o755
    owner "nobody"
    group "nogroup"
  end

  execute "/srv/#{year}.stateofthemap.org" do
    action :nothing
    command "jekyll build --trace"
    cwd "/srv/#{year}.stateofthemap.org"
    user "nobody"
    group "nogroup"
  end

  ssl_certificate "#{year}.stateofthemap.org" do
    domains ["#{year}.stateofthemap.org", "#{year}.stateofthemap.com"]
    notifies :reload, "service[apache2]"
  end

  apache_site "#{year}.stateofthemap.org" do
    template "apache.jekyll.erb"
    directory "/srv/#{year}.stateofthemap.org/_site"
    variables :year => year
  end
end

template "/etc/cron.daily/sotm-backup" do
  source "backup.cron.erb"
  owner "root"
  group "root"
  mode 0o750
  variables :passwords => passwords
end
