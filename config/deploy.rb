require "bundler/capistrano"


server "ec2-50-112-82-59.us-west-2.compute.amazonaws.com", :web, :app, :cardholder, :db, primary: true

set :user, "ubuntu"
ssh_options[:keys] = ["#{ENV['HOME']}/keys/test1.pem"] 
ssh_options[:forward_agent] = true
default_run_options[:pty] = true


set :application, "store"
set :repository,  "git@github.com:jake-veribuy/veribuy-dev.git"
#set :deploy_to, "/var/www/apps/#{application}"
#set :deploy_to, "~/rails_projects/veribuy_dev"
set :deploy_to, "/home/#{user}/apps/#{application}"
#set :deploy_to, "/var/www"
set :rails_env, "production"
set :scm, :git
#set :deploy_via, :remote_cache
set :branch, "master"

# if you want to clean up old releases on each deploy uncomment this:
# after "deploy:restart", "deploy:cleanup"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end
