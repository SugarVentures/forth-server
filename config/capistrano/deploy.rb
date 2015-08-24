# config valid only for current version of Capistrano
lock '3.4.0'

set :repo_url, 'git@github.com:SugarVentures/forth-server.git'
set :user, 'ubuntu'

set :rvm, File.join('/home', fetch(:user), '.rvm', 'bin', 'rvm')
set :ruby_version, `cat .ruby-version`

set :scm, :git
set :format, :pretty
set :log_level, :debug
set :pty, false

set :linked_files, %w{config/database.yml config/secrets.yml config/newrelic.yml public/robots.txt}
set :linked_dirs, %w{public/assets log certs}

set :rvm_type, :system
set :keep_releases, 5

set :ssh_options, {
                   keys: [File.join(ENV['HOME'],'.ssh','forth','aws','forth-staging.pem'),
                          File.join(ENV['HOME'],'.ssh','forth','aws','forth-production.pem'),
                          File.join(ENV['HOME'],'.ssh','id_rsa')],
                   forward_agent: true
                   }

namespace :deploy do
  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  after :publishing, :restart

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
#      within release_path do
#        execute :rake, 'cache:clear'
#      end
    end
  end

  namespace :tags do
    desc "Automatically create a git tag in the form 'deploy_yyyy_mm_dd_hh_mm'"
    task :create do
      tag_name = Time.now.strftime("%Y-%m-%d_%H%M")
      ref = `git ls-remote #{fetch(:repo_url)} refs/heads/#{fetch(:branch)} | awk '{print $1}'`.chomp
      system "git tag -a -m 'Deployment on #{fetch(:stage)}' #{tag_name} #{ref}"
      system "git push origin #{tag_name}"
      if $? != 0
        raise "Pushing tag to origin failed"
      end
    end
  end
end
