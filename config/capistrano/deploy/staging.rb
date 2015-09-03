server 'ec2-52-76-92-162.ap-southeast-1.compute.amazonaws.com', user: 'ubuntu', roles: %w{web app db}

set :stage, 'staging'
set :application, 'forth-staging'
set :branch, `git rev-parse --abbrev-ref HEAD`.chomp
set :deploy_to, "/var/proj/#{fetch(:application)}"
