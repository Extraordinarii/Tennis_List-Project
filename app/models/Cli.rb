class CommandLineInterface

    def prints_out_all_matches(user_id)
        Match.all.each do |match|
            player = Player.find(match.player_one_id)
            player2 = Player.find(match.player_two_id)
            puts player.name + " vs " + player2.name + " the final score; " + match.score
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
        ## returns prompt of list of all players you currently have followed
        ## then allows you to select to delete 
        ## at end of list, allow to exit/go back to
        follow_menu(user_id) 
    end 
    def add_players_conditionals
        #this method should; 
        #check if a duplicate follow exists within the database

        #allow users to search by 1 or 2 characters 
        #then it should bring up a prompt to allow users to add  based on search result
        #and allow user to exit if they want too


    end 

    def add_players(user_id)  ##passing user_id as soon as you log in 
        Player.all.each do |player| 
            puts player.name
        end 
        puts "Please enter a player name you wish to follow"
        name = gets.chomp 
        searched_data = Player.find_by(name: name) ##later check if name already exists inside user list
        Follow.create(player_id: searched_data.id, user_id: user_id)

        Follow.all.each do |follow| 
            
            if follow.user_id == user_id 
                puts "You have followed: " + follow.player.name
            end
            end 
            prompt = TTY::Prompt.new 
            choice = [{name: "Yes", value: 1},{name: "No", value: 2}]
            user_input = prompt.select("Would you like to add more players?", choice)
            if user_input == 1 
                add_players(user_id)
            elsif user_input == 2 
                follow_menu(user_id)
            end 
        ##prompt will ask "what is the name of the player you want to find "
            ##find_name = gets.chomp 
            ## Player.all.find_by ?
            ##hey does gets.chomp == find_by name 

        ###after adding player, returns follow list that includes new player then sends back to follow menu 
        #follow_menu #this is follow menu
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
    #add = find_by(name), #delete LIST ALL FOLLOWS, select to delete ie; pulls up prompt with your data 
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
    #prompt return
    #return a list of players
end 

def follow_menu(user_id) #FOLLOW_MENU
    #puts out information regarding list of players that you have
    #while nil output "you currently aren't following anyone"
    puts "\n"
    print "Your current list contains "
     current_list_of_players(user_id)
    
    prompt = TTY::Prompt.new
    choices = [{name: "Update my list", value: 1},{name: 'Return to main menu', value: 2},{name: 'Logout', value: 3}]
    user_input = prompt.select("Please make your choice", choices)
    follow_menu_selector(user_input, user_id)
    #Follows.where()  ##user_id matches ? // ##current list of players
    
    #AT THE END IT GIVES OPTION TO UPDATE MY LIST LOG OUT OR MAIN MENU
    
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

def login_screen
    # pastel = Pastel.new   ##we make this into a pretty front page
    # font = TTY::Font.new()
    # puts pastel.yellow.bold.detach(font.write('Tennis things!'))

    prompt = TTY::Prompt.new 

    choices = [{name: "Login", value: 1},{name: 'Create an account', value: 2},{name: 'Exit', value: 3}]

    user_input = prompt.select("Please make your choice", choices)
    runner(user_input)
end

def runner(user_input)
   # user_input = login_screen
   # return login_screen if !user._a?(User)
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
        check_for_duplicates = User.all.each {|user| user.user_name == username_input}
        if username_input.size > 4 
            if check_for_duplicates == false 
                return false 
            else 
                puts "Please enter a username that's not taken."
            end 
        else 
            puts "Please enter a username longer than 4 characters."
        end 
    end 
    #                username_input = prompt.ask("That username is already in use, please choose a different name")

    def password_checker(user_password_input)
        if user_password_input.size < 6
            return false 
        else 
            return true 
        end 
        ##verify that the input is longer than 6 characters long
    end 

    def create_account ###if acc exists, loop w/ "create a different unique name"
    prompt = TTY::Prompt.new 
    username_input = prompt.ask("Please enter a username")
            verification_process = user_verification(username_input)
            
    user_password_input = prompt.mask("Please enter a password that is longer than 6 characters ")
    ##do an if statement, that checks if password is longer than 6 characters
    while password_checker == false do 
        user_password_input = prompt.mask("Please enter a password longer than 6 characters")
         password_checker(user_password_input)
    end 
    User.create(
        user_name: verification_process,       ##implement minimum character required for name
        user_password: user_password_input  ##implement minimum character required for password
    )
    puts "Your account has been created!"
        login_screen
    end 

    def fantasy_tennis(user_id)
        prompt = TTY::Prompt.new
        saved_data = Player.all
        player1_input = prompt.select('Please select player one') do |menu|
            saved_data.each do |player| 
                 menu.choice player.name
            end 
        end
        Player.delete(player1_input) 
        player2_input = prompt.select('Please select player two') do |menu|
            saved_data.each do |player|
                menu.choice player.name
            end 
        end 
        Player.create(player1_input)
            player1_id = player1_input.id
            random_gen_holder = fantasy_gen
        Match.create(player_one_id: player1_input.id, player_two_id: player2_input.id, score: random_gen_holder)
        main_menu(user_id)
    end 

    def fantasy_gen
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
            if a > b && c > d 
                puts "#{a}-#{b}, #{c}-#{d}"
                puts "Player 1 has won the match"
            elsif b > a && d > c 
                puts "#{a}-#{b}, #{c}-#{d}"
                puts "Player 2 has won the match"
            else
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
                        if a > b && e > f || c > d && e > f 
                            puts "#{a}-#{b}, #{c}-#{d}, #{e}-#{f}"
                            puts "Player 1 has won the match"
                        else
                            puts "#{a}-#{b}, #{c}-#{d}, #{e}-#{f}"
                            puts "Player 2 has won the match"
                        end
            end
    end
    
    def run 
        login_screen ##calls the app to start up (the main login screen)
    end 
end 