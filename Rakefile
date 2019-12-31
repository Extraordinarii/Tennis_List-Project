require_relative './config/environment'
require 'sinatra/activerecord/rake'

desc 'starts a console'
task :console do
  ActiveRecord::Base.logger = Logger.new(STDOUT)
  Pry.start
end

desc 'start my app'
task :start do 
  puts "App is starting, please do not shut down."
  old_logger = ActiveRecord::Base.logger
  ActiveRecord::Base.logger = nil
  system 'ruby bin/run.rb'
end 
