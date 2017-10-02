environment_variables = YAML.load_file(File.dirname(__FILE__) + '/..' + '/config/application.yml')
lock "3.9.1"

set :application, 'fabrica'
set :repo_url, 'https://github.com/lmajowka/shareyourtest'
set :deploy_to, '/var/www/shareyourtest'
set :stages, %w(production staging)

set :ec2_access_key_id, environment_variables['EC2_ACCESS_KEY_ID']
set :ec2_secret_access_key, environment_variables['EC2_SECRET_ACCESS_KEY']
set :passenger_roles, [:app, :db, :web]

ec2_role :db,  user: 'deploy'
ec2_role :app,  user: 'deploy'
ec2_role :web,  user: 'deploy'

set :linked_files, ['config/application.yml','config/database.yml']

namespace :deploy do

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
    end
  end

end
