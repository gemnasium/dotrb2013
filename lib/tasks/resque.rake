require 'resque/tasks'
require 'resque_scheduler/tasks'

task "resque:setup" => :environment do
  config_path = File.join(Rails.root, 'config/resque_schedule.yml')
  Resque.schedule = YAML.load_file config_path
end
