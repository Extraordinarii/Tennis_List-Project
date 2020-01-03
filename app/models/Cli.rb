class CommandLineInterface

    def prints_out_all_matches(user_id)
        Match.all.each do |match|
            player = Player.find(match.player_one_id)
            player2 = Player.find(match.player_two_id)
            puts player.name + " vs " + player2.name + " the final score; " + match.score.to_s
        end
        main_menu(user_id)
    end 

    def delete_players(user_id)
            prompt = TTY::Prompt.new 
       value = 0
            saved_data = Follow.all.select {|follow| follow.user_id == user_id}
        input_value = prompt.select('Which person would you like to unfollow') do |menu|
            saved_data.each do |follow| 
                 menu.choice follow.player.name, value: follow.id
            end 
        end
        Follow.delete(input_value[:value])
        follow_menu(user_id) 
    end 

    def add_players(user_id)  ##passing user_id as soon as you log in 
        prompt = TTY::Prompt.new 
        puts "Please enter a player name you wish to follow"
        players = Player.all.filter do |player| 
            !Follow.find_by(user_id: user_id, player_id: player.id)
        end 
        name = prompt.select('Type in the name', players.map{|player| player.name}, filter: true)
        searched_data = Player.find_by(name: name) ##later check if name already exists inside user list
        Follow.create(player_id: searched_data.id, user_id: user_id)

        Follow.all.each do |follow| 
            
        if follow.user_id == user_id 
            puts "You have followed: " + follow.player.name
        end
    end 
            
            choice = [{name: "Yes", value: 1},{name: "No", value: 2}]
            user_input = prompt.select("Would you like to add more players?", choice)
            if user_input == 1 
                add_players(user_id)
            elsif user_input == 2 
                follow_menu(user_id)
            end 
    end 
    
def update_my_list(user_id) #this is the menu that holds add / delete 
    prompt = TTY::Prompt.new
    choices = [{name: "Add players", value: 1},{name: 'Delete players', value: 2},{name: 'Go back', value: 3}]
    user_input = prompt.select("Please make your choice", choices)
    if user_input == 1 
        add_players(user_id)
    elsif user_input == 2
        delete_players(user_id)
    elsif user_input == 3 #log out
        follow_menu(user_id)
    end
end 




def follow_menu_selector(user_input, user_id)
    if user_input == 1 
        update_my_list(user_id)  #list of players & search players
    elsif user_input == 2
        main_menu(user_id)
    elsif user_input == 3 #log out
        login_screen
    end
end

def current_list_of_players(user_id)
    array_containing_players = []
    counter = 0
    saved_data = Follow.all.select {|follow| follow.user_id == user_id}
    if saved_data
         saved_data.each do |follow| 
            array_containing_players << follow.player.name
            if counter == 0 
             puts "\n" + follow.player.name
             counter -= -1 
            else 
                puts follow.player.name
            end 
         end 
    end 
    if array_containing_players.size == 0 
        puts "no one, please add someone to see them in your list"
    end 
       puts "\n"
end 

def follow_menu(user_id) #FOLLOW_MENU
    puts "\n"
    print "Your current list contains "
     current_list_of_players(user_id)
    
    prompt = TTY::Prompt.new
    choices = [{name: "Update my list", value: 1},{name: 'Return to main menu', value: 2},{name: 'Logout', value: 3}]
    user_input = prompt.select("Please make your choice", choices)
    follow_menu_selector(user_input, user_id)
end

def main_menu_selector(user_input, user_id)
    if user_input == 1 
        follow_menu(user_id)  #list of players & search players
    elsif user_input == 2
        update_my_list(user_id)
    elsif user_input == 3 #see matches
        prints_out_all_matches(user_id)
    elsif user_input == 4 
        fantasy_tennis(user_id)
    elsif user_input == 5 
        login_screen
    end
end

def main_menu(user_id)
    puts "MAIN MENU"
    prompt = TTY::Prompt.new 
    choices = [{name: "See my list", value: 1},{name: 'Update my list', value: 2},{name: 'See matches', value: 3},{name: 'Fantasy Tennis', value: 4},{name: 'Logout', value: 5}]
    ###choice # see my list, update my list(select from all, or search for specific players)
    user_input = prompt.select("Please make your choice", choices)
    main_menu_selector(user_input, user_id)
end
def welcome_screen
    font = TTY::Font.new()
    pastel = Pastel.new   ##we make this into a pretty front page
  thing = '
  .                                 ____
  |\                               /xxxx\
  |X\                             |xxxxxx|
   XX\         _    O_/           |xxxxxx|      _
    XX\    o  (#)==_/\            \xxxxxx/     (~)
     XX\             /\/           \xxxx/      
      XX\           /               \--/
       XX\.                          ||
        XX|                          ||
         X|                          []' 
                  
   puts pastel.yellow.bold(font.write('Just     Tennis     Things!'))
   puts pastel.yellow.bold(thing)
   login_screen
end 

def login_screen


    prompt = TTY::Prompt.new 

    choices = [{name: "Login", value: 1},{name: 'Create an account', value: 2},{name: 'Exit', value: 3}]

    user_input = prompt.select("Please make your choice", choices)
    runner(user_input)
end

def runner(user_input)
    if user_input == 1 
        account_login
    elsif user_input == 2
        create_account
    elsif user_input == 3 ##implement "throw error if other numbers or keys are entered and it forces user back to previous screen"
        exit 
    end
end 

    def account_login
    prompt = TTY::Prompt.new 
        username_input = prompt.ask("Username:")
        user = User.find_by(user_name: username_input)
        if !user 
        choices = [{name: "Retry", value:1},{name: "Go back", value: 2}]
        input = prompt.select("Go back", choices)
         if input == 2 
            login_screen
         elsif input == 1
            account_login
            end 
        end 
        while user == nil 
            username_input = prompt.ask("Please enter the correct username." + "\n" + "Username:")
            user = User.find_by(user_name: username_input) 
         end
        user_password_input = prompt.mask("Password:") 
        while user.user_password != user_password_input 
            puts "Incorrect password, please enter the correct password"
            user_password_input = prompt.mask("Password:")
        end 
        main_menu(user.id)
    end 

    def user_verification(username_input)
        prompt = TTY::Prompt.new
        check_for_duplicates = User.all.find do |user| 
            user.user_name == username_input 
        end 
        if username_input.size > 3 
            if !check_for_duplicates
                user_password_input = prompt.mask("Please enter a password that is longer than 6 characters ")
                ##do an if statement, that checks if password is longer than 6 characters
                while password_checker(user_password_input) == false do 
                    user_password_input = prompt.mask("Please enter a password longer than 6 characters")
                end 
                        User.create(
                        user_name: username_input,       ##implement minimum character required for name
                        user_password: user_password_input  ##implement minimum character required for password
                    )
                
                    puts "Your account has been created!"
            else
                puts "Please enter a different username"
            end 
        else 
            puts "Please enter a Username longer than #{username_input.size}"
        end 
    end 
    #                username_input = prompt.ask("That username is already in use, please choose a different name")


    def password_checker(user_password_input)
        if !user_password_input || user_password_input.size < 6
            return false 
        else 
            return true 
        end 
        ##verify that the input is longer than 6 characters long
    end 

    def create_account ###if acc exists, loop w/ "create a different unique name"
        prompt = TTY::Prompt.new 
        username_input = prompt.ask("Please enter a username")
        while username_input == nil 
            username_input = prompt.ask("Please enter in a username, and not a blank space")
        end 
        user_verification(username_input)
        login_screen
    end 

    def fantasy_tennis(user_id)
        prompt = TTY::Prompt.new
        saved_data = Player.all
        player1_input = prompt.select('Please select player one') do |menu|
            saved_data.each do |player| 
                 menu.choice player.name, value: player
            end 
        end
        player2_input = prompt.select('Please select player two') do |menu|
            saved_data.each do |player|
                if player.name != player1_input[:value].name
                    menu.choice player.name, value: player
                end
            end 
        end 
            random_gen_holder = fantasy_gen
        Match.create(player_one_id: player1_input[:value].id, player_two_id: player2_input[:value].id, score: random_gen_holder)
        main_menu(user_id)
    end 

    def fantasy_gen
        set1_winner_toggle = rand(0..1)
        if set1_winner_toggle == 0 
            a = rand(0..7)
            b = 0
            if a <= 4
            b = 6 
            end
            if a == 5 || a == 6
            b = 7
            end
            if a == 7
            b = 6
            end
        else 
            b = rand(0..7)
            a = 0
            if b <= 4
            a = 6 
            end
            if b == 5 || b == 6
            a = 7
            end
            if b == 7
            a = 6
            end
        end
        set2_winner_toggle = rand(0..1)
        if set2_winner_toggle == 0 
            c = rand(0..7)
            d = 0 
            if c <= 4
            d = 6
            end
            if c == 5 || c == 6
            d = 7
            end
            if c == 7 
            d = 6 
            end
        else
            d = rand(0..7)
            c = 0
            if d <= 4
            c = 6
            end 
            if d == 5 || d == 6
            c = 7
            end
            if d == 7
            c = 6
            end
        end
            if a > b && c > d 
                puts "#{a}-#{b}, #{c}-#{d}"
                puts "Player 1 has won the match"
            elsif b > a && d > c 
                puts "#{a}-#{b}, #{c}-#{d}"
                puts "Player 2 has won the match"
            else
                set3_winner_toggle = rand(0..1)
                if set3_winner_toggle == 0 
                    e = rand(0..7)
                    f = 0
                    if e <= 4
                       f = 6 
                    end
                    if e == 5 || e == 6
                       f = 7
                    end
                    if e == 7
                    f = 6
                    end
                else
                    f = rand(0..7)
                    e = 0 
                    if f <= 4
                        e = 6
                    end
                    if f == 5 || f == 6
                        e = 7
                    end
                    if f == 7 
                    e = 6
                    end
                end
                        if a > b && e > f || c > d && e > f 
                            puts "Player 1 has won the match"
                        puts "#{a}-#{b}, #{c}-#{d}, #{e}-#{f}"
                             "#{a}-#{b}, #{c}-#{d}, #{e}-#{f}"
                        else
                            puts "Player 2 has won the match"
                        puts "#{a}-#{b}, #{c}-#{d}, #{e}-#{f}"
                             "#{a}-#{b}, #{c}-#{d}, #{e}-#{f}"
                        end
            end
    end
    
    
    def run 
        welcome_screen ##calls the app to start up (the main login screen)
    end 
end 