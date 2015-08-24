set :deploy_config_path, 'config/capistrano/deploy.rb'
set :stage_config_path, 'config/capistrano/deploy'

require 'capistrano/setup'
require 'capistrano/deploy'
require 'capistrano/rails'
require 'capistrano/rvm'

Dir.glob('lib/capistrano/tasks/*.rake').each { |r| import r }
