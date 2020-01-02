#cli interface here
require_relative '../config/environment'

def start
    old_logger = ActiveRecord::Base.logger
    ActiveRecord::Base.logger = nil
end 

start()
cli = CommandLineInterface.new 
cli.run