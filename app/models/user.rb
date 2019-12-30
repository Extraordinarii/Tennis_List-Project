class User < ActiveRecord::Base 
    has_many :follows 
    has_many :players, through: :follows 

end