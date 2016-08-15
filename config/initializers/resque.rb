require 'resque'
require 'resque/scheduler'

# configure redis connection
Resque.redis = "localhost:6379"


Resque.after_fork = Proc.new { ActiveRecord::Base.establish_connection }

# init logger
if Rails.env.production?
  Resque.logger = Logger.new("#{Rails.root}/log/resque.log")
end