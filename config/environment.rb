require 'bundler'
Bundler.require
require 'active_record'

DB = ActiveRecord::Base.establish_connection(
    :adapter => 'sqlite3', 
    :database => './db/development.db'
    )




