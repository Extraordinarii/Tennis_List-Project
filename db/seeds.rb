User.destroy_all
#ActiveRecord::Base.connection.execute('ALTER TABLE users AUTO_INCREMENT = 1')
Match.destroy_all
Player.destroy_all
Player.reset_pk_sequence

User.create(user_name: "Ben", user_password: "k") ## Create annoying thing that only allows over 4 characters
User.create(user_name: "Al", user_password: "f")  ## and over 5 characters for password
Player.create(name: "Roger")
Player.create(name: "Rafa")
Player.create(name: "Novak")
Player.create(name: "Daniil")
Player.create(name: "Dominic")
Player.create(name: "Stefanos")
Player.create(name: "Mario")
Player.create(name: "David")
Player.create(name: "Stan")
Player.create(name: "Ben")

Match.create(player_one_id: 1, player_two_id: 2, score: "6-0, 6-0")
Match.create(player_one_id: 2, player_two_id: 3, score: "7-6, 3-6, 6-2")