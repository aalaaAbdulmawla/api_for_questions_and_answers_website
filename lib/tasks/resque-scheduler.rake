# Resque tasks
require 'resque/tasks'
require 'resque/scheduler/tasks'

namespace :resque do
  task :setup do
    require 'resque'
    require 'resque/scheduler'
    require 'resque/scheduler/server'

  end

  task :setup_schedule => :setup do
    require 'resque-scheduler'

    # The schedule doesn't need to be stored in a YAML, it just needs to
    # be a hash.  YAML is usually the easiest.
    # Resque.schedule = YAML.load_file(File.join(Rails.root, 'config/resque_scheduler.yml'))
    Resque::Scheduler.dynamic = true

  end

  task :scheduler => :setup_schedule
end