server 'ec2-52-76-63-68.ap-southeast-1.compute.amazonaws.com', user: 'ubuntu', roles: %w{web app db}

set :stage, 'production'
set :application, 'forth-production'
set :branch, 'master'
set :deploy_to, "/var/proj/#{fetch(:application)}"

after :deploy, "deploy:tags:create" unless fetch(:skip_tag, false)
