class CreateFollows < ActiveRecord::Migration[5.2]
    def change
        create_table :follows do |t|
            t.integer :player_id  
            t.integer :user_id
            
        
        end
    end
end