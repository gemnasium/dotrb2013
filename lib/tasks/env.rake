desc "Show environment settings"
task :showenv do
  if Rake::Task.task_defined? :dotenv
    Rake::Task['dotenv'].invoke
  end
  require 'pp'
  pp ENV
end
