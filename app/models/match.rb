class Match < ActiveRecord::Base 
    attr_accessor :score
    has_and_belongs_to_many :player 

end