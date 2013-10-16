# This file is used by Rack-based servers to start the application.

require ::File.expand_path('../config/environment',  __FILE__)

# load resque-scheduler to get extra tabs in resque-web
# FIXME no schedule in "Schedule" tab before we launch
# resque:scheduler rake task, even if we define Resque.schedule here;
# workaround is to always run resque:scheduler rake task!
require 'resque_scheduler'
require 'resque/scheduler'
require 'resque_scheduler/server'

run Rails.application
