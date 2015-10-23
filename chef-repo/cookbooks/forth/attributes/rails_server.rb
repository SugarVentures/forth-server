# rvm
normal['rvm']['rubies'] = ['2.2.3']
normal['rvm']['default_ruby'] = node['rvm']['rubies'].first
normal['rvm']['user_default_ruby'] = node['rvm']['default_ruby']
normal['rvm']['gems'][node['rvm']['default_ruby']] = [{name: "bundler"}, {name: "rake"}]
normal['rvm']['gem_package']['rvm_string'] = node['rvm']['default_ruby']
normal['rvm']['gpg']['keyserver'] = "hkp://keys.gnupg.net"
normal['rvm']['gpg']['homedir'] = "/root"
normal['rvm']['install_rubies'] = true


# nginx
normal['nginx']['version'] = '1.9.5'
normal['nginx']['dir'] = '/etc/nginx'
normal['nginx']['log_dir'] = '/var/log/nginx'
normal['nginx']['binary'] = "/opt/nginx-#{node['nginx']['version']}/sbin"
normal['nginx']['source']['sbin_path'] = "#{node['nginx']['binary']}/nginx"
normal['nginx']['init_style'] = 'init'
normal['nginx']['default_site_enabled'] = false
normal['nginx']['source']['version'] = node['nginx']['version']
normal['nginx']['source']['modules'] = ["nginx::http_stub_status_module",
                                        "nginx::http_ssl_module",
                                        "nginx::http_gzip_static_module",
                                        "nginx::passenger"]
normal['nginx']['source']['prefix'] = "/opt/nginx-#{node['nginx']['source']['version']}"
normal['nginx']['source']['default_configure_flags'] = ["--prefix=#{node['nginx']['source']['prefix']}",
                                                        "--conf-path=#{node['nginx']['dir']}/nginx.conf",
                                                        "--sbin-path=#{node['nginx']['source']['sbin_path']}"]
normal['nginx']['source']['url'] = "http://nginx.org/download/nginx-#{node['nginx']['source']['version']}.tar.gz"

# passenger
normal['nginx']['passenger']['version'] = '5.0.16'
normal['nginx']['passenger']['install_method'] = 'source'
normal['nginx']['passenger']['ruby'] = "#{node['rvm']['root_path']}/wrappers/ruby-#{node['rvm']['default_ruby']}/ruby"
normal['nginx']['passenger']['gem_binary'] = "#{node['rvm']['root_path']}/wrappers/ruby-#{node['rvm']['default_ruby']}/gem"
normal['nginx']['passenger']['root'] = "#{node['rvm']['root_path']}/gems/ruby-#{node['rvm']['default_ruby']}/gems/passenger-#{node['nginx']['passenger']['version']}"
normal['nginx']['configure_flags'] = ["--add-module=#{node['rvm']['root_path']}/gems/ruby-#{node['rvm']['default_ruby']}/gems/passenger-#{node['nginx']['passenger']['version']}/ext/nginx"]
normal['nginx']['passenger']['packages']['debian'] = ["libcurl4-gnutls-dev"]

# project
default['forth']['rvm_path'] = "#{node['rvm']['root_path']}/gems/ruby-#{node['rvm']['default_ruby']}/bin:#{node['rvm']['root_path']}/gems/ruby-#{node['rvm']['default_ruby']}@global/bin:#{node['rvm']['root_path']}/rubies/ruby-#{node['rvm']['default_ruby']}/bin"
default['forth']['project_dir'] = "/var/proj/forth-#{node.chef_environment}"
default['forth']['server_url'] = "forth.tv" # without www!
