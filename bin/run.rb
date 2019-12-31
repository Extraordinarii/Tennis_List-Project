#cli interface here
require_relative '../config/environment'

def start
        old_logger = ActiveRecord::Base.logger
        ActiveRecord::Base.logger = nil

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
            ##prompt will ask "what is the name of the player you want to find "
                ##find_name = gets.chomp 
                ## Player.all.find_by ?
                ##hey does gets.chomp == find_by name 
    
            ###after adding player, returns follow list that includes new player then sends back to follow menu 
            #follow_menu #this is follow menu
           follow_menu(user_id)
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
    def follow_menu(user_id) #FOLLOW_MENU
        #puts out information regarding list of players that you have
        #while nil output "you currently aren't following anyone"
        
        follow_list =  Follow.all.select {|follow| follow.user_id == user_id}
        # ##outputs list of follows, prettify it later
        # if follow_list == nil 
        #     puts "hey you ain't got no follows"
        # else
        #     puts follow_list
        #end 
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
        elsif user_input == 3 #log out
            login_screen
        end
    end

    def main_menu(user_id)
        puts "MAIN MENU"
        prompt = TTY::Prompt.new 
        choices = [{name: "See my list", value: 1},{name: 'Update my list', value: 2},{name: 'Logout', value: 3}]
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
            if user == nil #### only say, the below after the password is entered ie; Wrong username or wrong password.
                username_input = prompt.ask("Please enter the correct username. /n Username:")
             end
            user_password_input = prompt.mask("Password:")
            if user.user_password != user_password_input 
                puts "Incorrect password, to verify that you are human, please do this captcha"
                    user = nil 
            end 
            main_menu(user.id)
    end 
 
    def create_account ###if acc exists, loop w/ "create a different unique name"
        prompt = TTY::Prompt.new 
        username_input = prompt.ask("Enter a username you would like to use")
        user_password_input = prompt.mask("Please enter a password")
        User.create(
            user_name: username_input,
            user_password: user_password_input
        )
        puts "Your account has been created!"
    login_screen
    end 
    login_screen ##calls the app to start up (the main login screen)

    def current_list_of_players
        Player.all
        #prompt return
        #return a list of players
    end 

    def print_follow_list #with new player 
        #call it after adding a new player to your list

        #returns to update_my_list
    end 


    def delete_players
        
        ## returns prompt of list of all players you currently have followed
        ## then allows you to select to delete 
        ## at end of list, allow to exit/go back to 
    end 

end
start()


=begin 

def prints_out_all_matches
    match_array = []
    Match.all.each do |match|
        name = player.find_by(match.player_one_id)
        name2 = player.find_by(match.player_two_id)
        score = match. ##find a way to acquire Match.all.score 
        match_array << name,name2,score
    end 
    match_array
end 
=end 
