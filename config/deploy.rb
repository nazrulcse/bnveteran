# # config valid only for current version of Capistrano
# lock "3.8.2"
#
# set :application, 'Bnrpsocial'
# set :repo_url, 'https://github.com/selimrezael/bnrpsocial.git'
# # set :environment , 'production'
# #set :branch, "new_design"
#
# # Default deploy_to directory is /var/www/my_app_name
# set :deploy_to, '/home/deploy/bnrpsocial'
#
# namespace :deploy do
#
#  after :restart, :clear_cache do
#    on roles(:web), in: :groups, limit: 3, wait: 10 do
#      # Here we can do anything such as:
#      # within release_path do
#      #   execute :rake, 'cache:clear'
#      # end
#    end
#  end
#
# end

# define multiple deployments

set :stages, %w(production staging)
# set :default_stage, 'staging'

# set :rvm_ruby_string, :local              # use the same ruby as used locally for deployment
# set :rvm_autolibs_flag, "read-only"       # more info: rvm help autolibs
#
# before 'deploy:setup', 'rvm:install_rvm'  # install/update RVM
# before 'deploy:setup', 'rvm:install_ruby' # install Ruby and create gemset, OR:



# config valid only for current version of Capistrano
lock "3.8.2"

set :application, "bnveteran"
set :repo_url, 'git@github.com:nazrulcse/bnveteran.git'
# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
# set :deploy_to, "/var/www/my_app_name"

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# set :ssh_options, {
#                     :keys => '/home/syftet/Desktop/bnveteran/bnveteran_production.pem'
#                 }

# Default value for :pty is false
# set :pty, true
# if environment == "production"
#    server '139.59.119.50',
#           :user => 'deployer',
#           :roles => %w{web app db}
#  end
#
# if environment == "staging"
#   server '139.59.107.98',
#          :user => 's_deployer',
#          :roles => %w{web app db}
# end


set :rvm_ruby_version, '2.3.1'

# Default value for :linked_files is []
set :linked_files, %w{config/database.yml config/secrets.yml config/application.yml}

# Default value for linked_dirs is []
set :linked_dirs, %w{log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system public/sitemaps public/assets public/uploads pdf_files}

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# set :assets_prefix, 'pipeline_assets'

# Default value for keep_releases is 5
set :keep_releases, 5

namespace :deploy do
  #before :deploy, "deploy:check_revision"
  #after 'deploy:symlink:shared', 'deploy:compile_assets_locally'
  after :finishing, 'deploy:cleanup'
  #before 'deploy:setup_config', 'nginx:remove_default_vhost'
  #after 'deploy:setup_config', 'nginx:reload'
  #after 'deploy:setup_config', 'monit:restart'
  after 'deploy:publishing', 'deploy:restart'

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      # Your restart mechanism here, for example:
      execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  # after :publishing, :restart

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end
end

# task :upload_secret_files do
#   on roles(:all) do |host|
#     begin
#       execute "mkdir #{shared_path}/config"
#     rescue
#     end
#     upload! "config/application.yml", "#{shared_path}/config/application.yml"
#   end
# end

# desc 'Invoke a rake command on the remote server'
# task :invoke, [:command] => 'deploy:set_rails_env' do |task, args|
#   on primary(:app) do
#     within current_path do
#       with :rails_env => fetch(:rails_env) do
#         rake args[:command]
#       end
#     end
#   end
# end