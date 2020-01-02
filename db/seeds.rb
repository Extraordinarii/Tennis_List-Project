User.destroy_all
#ActiveRecord::Base.connection.execute('ALTER TABLE users AUTO_INCREMENT = 1')
Match.destroy_all
Player.destroy_all
Player.reset_pk_sequence

 ## Create annoying thing that only allows over 4 characters
  ## and over 5 characters for password
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
Match.create(player_one_id: 3, player_two_id: 5, score: "6-7, 4-6")
Match.create(player_one_id: 10, player_two_id: 1, score: "7-5, 6-4")
Match.create(player_one_id: 2, player_two_id: 6, score: "3-6, 6-4, 6-7")
Match.create(player_one_id: 9, player_two_id: 5, score: "6-2, 6-4")
Match.create(player_one_id: 8, player_two_id: 2, score: "2-6, 6-7")
Match.create(player_one_id: 5, player_two_id: 10, score: "6-1, 7-6")
Match.create(player_one_id: 2, player_two_id: 5, score: "7-6, 3-6, 7-6")
Match.create(player_one_id: 9, player_two_id: 4, score: "6-0, 6-1")
Match.create(player_one_id: 3, player_two_id: 7, score: "2-6, 6-7")
Match.create(player_one_id: 7, player_two_id: 4, score: "7-6, 4-6, 6-4")
Match.create(player_one_id: 6, player_two_id: 8, score: "6-3, 6-4")