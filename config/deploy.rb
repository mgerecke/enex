###############################
#
# Capistrano Deployment on shared Webhosting by RailsHoster
#
# maintained by support@railshoster.de
#
###############################

def gemfile_exists? 
  File.exists? "Gemfile"
end

def gemfile_lock_exists?
  File.exists? "Gemfile.lock"
end

def rails_version
  if gemfile_exists? 
    rails_v = (Proc.new {
      file = File.new("Gemfile", "r")
    while (line = file.gets)
        if line =~ /^\s*gem\s+[\"\']rails[\"\'].+/
          version = line.scan(/(\d+)\.(\d+)\.(\d+)/).first.map {|x| x.to_i}
        end
      end
      file.close
      version
    }).call
  else 
    rails_v = nil
  end
  return rails_v
end

def rails_version_supports_assets?
  rails_v = rails_version
  return rails_v != nil && rails_v[0] >= 3 && rails_v[1] >= 1
end


#### Use the asset-pipeline and setup bulder
require 'capistrano/bundler'

set :bundle_roles, :all   
set :bundle_servers, -> { release_roles(fetch(:bundle_roles)) }
set :bundle_binstubs, -> { shared_path.join('bin') } 
set :bundle_without, %w{development test}.join(' ') 
set :bundle_path, -> { shared_path.join('bundle') }
set :bundle_flags, '--deployment --quiet'
set :bundle_bins, %w{gem rake rails}

require 'capistrano/rails/assets' if rails_version_supports_assets?


#### Personal Settings

# application name ( should be rails1 rails2 rails3 ... )
set :application, "rails1"
set :stages, ["development"]

# repository location
set :repo_url, "mgerecke@github.com/enex.git"

# :subversionn or :git
set :scm, :git
set :scm_verbose, true

server("rho.railshoster.de", {
  :user => "user01862291",
  :roles => [:web, :app, :db],
  :ssh_options => {
    :forward_agent => true,
    :auth_methods  => %w{publickey password},
    :password      => "EgTmzWVPNk"
  }
})

# set the location where to deploy the new project
set :deploy_to, "/home/user01862291/#{fetch(:application)}"


set :assets_roles,   :app
set :assets_prefix, 'assets'

set :linked_dirs, fetch(:linked_dirs, []).push("public/#{fetch(:assets_prefix)}") 
set :migration_role, :db

# change the environment if needed
set :rails_env, :production

# enable migration tasks if the deploy.rb was used into a rails app
require 'capistrano/rails/migrations' if rails_version


# don't use sudo it's not necessary
set :use_sudo, false



############################################
# Default Tasks by RailsHoster.de
############################################

namespace :deploy do
  desc "Restarting mod_rails with restart.txt"
  task :restart do
    on roles(:app), :in => :sequence, :wait => 5 do
      execute "touch #{fetch(:current_path)}/tmp/restart.txt"
    end
  end

  desc "Additional Symlinks ( database.yml, etc. )"
  before :migrate, :additional_symlink do
    on roles(:app) do
      execute "ln -fs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
    end
  end
end

