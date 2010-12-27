set :application, "todone"
set :repository,  "set your repository location here"

set :user, "basveeling"

set :scm, "git"
set :branch, "master"
default_run_options[:pty] = true
default_environment["PATH"] = "/opt/ruby-enterprise/bin:/usr/local/bin:/usr/bin:/bin"
#If you use submodules:
set :git_enable_submodules, 1

#Vul hier uw Github gegevens in
set :repository,  "git://github.com/basveeling/todoneclone.git"
set :user, "basveeling"
set :scm_passphrase, "Beter16"
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

set :deploy_to, "/home/#{user}/web_root"
set :use_sudo, false

ssh_options[:port] = 2222
default_run_options[:pty] = false

server "ssh.railscluster.nl", :app, :web, :db, :primary => true

# If you are using Passenger mod_rails uncomment this:
# if you're still using the script/reapear helper you will need
# these http://github.com/rails/irs_process_scripts

before "deploy:migrate", "deploy:bundle_install"

namespace :deploy do
  task :bundle_install do
    run "cd #{current_release} && bundle install --deployment"
  end
  task :start, :roles => :app do
    run "touch #{current_release}/tmp/restart.txt"
  end

  task :stop, :roles => :app do
    # Do nothing.
  end

  task :restart, :roles => :app do
    run "touch #{current_release}/tmp/restart.txt"
  end
end
