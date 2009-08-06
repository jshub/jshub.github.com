# Enable multistage deploys
#set :stages, %w(staging production)
#set :default_stage, "staging"
#require 'capistrano/ext/multistage'

puts "Deploying to PRODUCTION"
set :domain,      "jshub.org"

# construct the path to the repository
set :repository,   "git@github.com:jshub/jshub.github.com.git"

#If you log into your server with a different user name than you are logged 
#into your local machine with, youll need to tell Capistrano about that user 
#name.
set :user, "capistrano"

# webserver root symlink path for Trac
set :webroot, "/var/jshub/htdocs"

# all services are on the same server for now
role :app, domain
role :web, domain
role :db,  domain, :primary => true

set :application, "jshub-website"

# If you aren't deploying to /u/apps/#{application} on the target
# servers (which is the default), you can specify the actual location
# via the :deploy_to variable:
set :deploy_to,   "/var/capistrano/#{application}"

# If you aren't using Subversion to manage your source code, specify
# your SCM below:
set :scm,         "git"
set :scm_verbose, true
set :deploy_via,  :checkout
set :branch,      "master"
set :git_shallow_clone, 1

#By default, Capistrano will try to use sudo to do certain operations (setting 
#up your servers, restarting your application, etc.). If you are on a shared 
#host, sudo might be unavailable to you, or maybe you just want to avoid using sudo.
set :use_sudo,    false

# Liam: overide the default task as we are deploying a static site
namespace :deploy do
  desc "Restart Application"
  task :restart, :roles => :app do
    puts "Restart task has been disabled"
  end
end

# Custom
namespace :custom do
  
  desc 'Generate the website help and  documentation'
  task "website" do
    run "cd #{current_path} && jekyll --no-auto #{webroot}"
  end

  desc 'redo other symlinks in the web root'
  task :link_webroot do
    run "ln -nfs /var/capistrano/git/current/public #{webroot}/git"
    run "ln -nfs /var/capistrano/akita-on-rails/current/public #{webroot}/akita-on-rails"
    run "ln -nfs /var/capistrano/akita-on-rails/current/public #{webroot}/core"
    run "ln -nfs /var/capistrano/ui/current/public #{webroot}/ui"
    run "ln -nfs /var/capistrano/configurator/current/public #{webroot}/configurator"
    run "ln -nfs /var/capistrano/retail2/current/public #{webroot}/retail2"
  end

end

# use our custom tasks at the appropriate time
# e.g. before :deploy, :my_custom_task
#      after  "deploy:symlink", :do_this, :and_do_that
after "deploy:restart", "custom:website"
