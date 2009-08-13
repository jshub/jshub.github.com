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

# Liam: overide the default task as we are not using rails
namespace :deploy do
  desc "Restart Application"
  task :restart, :roles => :app do
    puts "Restart not needed"
  end
end


# Custom
namespace :custom do

  desc "Generate website in the webroot with Jekyll"
  task :website do
    puts "Generating website"
    run "cd #{current_path} && jekyll --no-auto /var/jshub/htdocs/"
  end
  
  desc 'reado symlinks in the web root.'
  task :link_webroot do
    run "ln -nfs /var/capistrano/git/current/public #{webroot}/git"
    run "ln -nfs /var/capistrano/core/current/public #{webroot}/core"
    run "ln -nfs /var/capistrano/ui/current/public #{webroot}/ui"
    run "ln -nfs /var/capistrano/configurator/current/public #{webroot}/configurator"
    run "ln -nfs /var/capistrano/retail2/current/public #{webroot}/retail2"
  end

end

after "deploy:restart", "custom:website"