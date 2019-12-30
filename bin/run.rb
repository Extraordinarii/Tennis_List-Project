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
            user = User.find_by(username: username_input)
            if user == nil #### only say, the below after the password is entered ie; Wrong username or wrong password.
                username_input = prompt.ask("Please enter the correct username. /n Username:")
             end
            user_password_input = prompt.mask("Password:")
            if user.password != user_password_input 
                puts "Incorrect password, to verify that you are human, please do this captcha"
                    user = nil 
            end 
            user 
    end 
 
    def create_account
        prompt = TTY::Prompt.new 
        username_input = prompt.ask("Enter a username you would like to use")
        user_password_input = prompt.mask("Please enter a password")
        User.create(
            user_name: username_input,
            password: user_password_input
        )
        puts "Your account has been created!"
    login_screen
    end 
    login_screen ##calls the app to start up (the main login screen)
end
start()