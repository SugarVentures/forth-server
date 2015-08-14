# See http://docs.opscode.com/config_rb_knife.html for more information on knife configuration options

current_dir = File.dirname(__FILE__)
log_level                :info
log_location             STDOUT
node_name                "shinya14"
client_key               "#{ENV['HOME']}/.chef/shinya.pem"
validation_client_name   "forth-validator"
validation_key           "#{ENV['HOME']}/.chef/forth-validator.pem"
chef_server_url          "https://api.opscode.com/organizations/forth"
cache_type               'BasicFile'
cache_options( :path => "#{ENV['HOME']}/.chef/checksums" )
cookbook_path            ["#{current_dir}/../cookbooks"]

knife[:aws_credential_file] = "#{ENV['HOME']}/.chef/jf2.aws.credentials"
knife[:region] = 'ap-southeast-1'
knife[:editor] = 'emacs'
knife[:secret_file] = '/etc/chef/forth_secret'
