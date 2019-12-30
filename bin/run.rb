#cli interface here
require_relative '../config/environment'

def start 

    def login_screen
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
            user 
            main_menu(user)
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

    def main_menu(user)
        puts "MAIN MENU"
        prompt = TTY::Prompt.new 
        choices = [{name: "See my list", value: 1},{name: 'Update my list', value: 2},{name: 'Logout', value: 3}]
        ###choice # see my list, update my list(select from all, or search for specific players)
        user_input = prompt.select("Please make your choice", choices)
        main_menu_selector(user_input)
    end

    def main_menu_selector(user_input)
        if user_input == 1 
            see_my_list  #list of players & search players
        elsif user_input == 2
            update_my_list
        elsif user_input == 3 #log out
            login_screen
        end
    end
    def follow_menu_selector(user_input)
        if user_input == 1 
            update_my_list  #list of players & search players
        elsif user_input == 2
            main_menu(user)
        elsif user_input == 3 #log out
            login_screen
        end
    end

    def see_my_list #FOLLOW_MENU
        #puts out information regarding list of players that you have
        prompt = TTY::Prompt.new
        choices = [{name: "Update my list", value: 1},{name: 'Return to main menu', value: 2},{name: 'Logout', value: 3}]
        user_input = prompt.select("Please make your choice", choices)
        follow_menu_selector(user_input)
        Follows.where()  ##user_id matches ? // ##current list of players
        
        #AT THE END IT GIVES OPTION TO UPDATE MY LIST LOG OUT OR MAIN MENU
        
    end
    def update_my_list_selector(user_input)
        if user_input == 1 
        add_players  #add players by name (find_by clause)
    elsif user_input == 2
        delete_players #deletes players in a list format 
    elsif user_input == 3 #go back
        see_my_list
    end
    end

    def update_my_list
        prompt = TTY::Prompt.new
        choices = [{name: "Add players", value: 1},{name: 'Delete players', value: 2},{name: 'Go back', value: 3}]
        user_input = prompt.select("Please make your choice", choices)
        update_my_list_selector(user_input)
        #add = find_by(name), #delete LIST ALL FOLLOWS, select to delete ie; pulls up prompt with your data 
    end 

    def current_list_of_players
        #prompt return
        #return a list of players
    end 

    def print_follow_list #with new player 

        #returns to update_my_list
    end 

    def add_players

        ###after adding player, returns follow list that includes new player then sends back to follow menu 
        see_my_list #this is follow menu
    end 
    def delete_players
    end 

end
start()