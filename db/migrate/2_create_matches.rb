class CreateMatches < ActiveRecord::Migration[5.2]
    def change
        create_table :matches do |t|
            t.integer :player_one_id
            t.integer :player_two_id
            t.string :score 
        
        end
    end
end