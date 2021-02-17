
class Cli 
    def self.prompt
        @@PROMPT = TTY::Prompt.new
    end

    def self.run
        puts "Hello, welcome to the weather app."
         account_check = prompt.yes?("Do you have an account?")
        if account_check
            username_check
        else
            create_account
        end
    end

    def self.create_account
        new_username = username_creation
        puts "That username is available."
        new_password = prompt.ask("Please enter a password:")
        User.create(username: new_username, password: new_password)
        puts "Congratulations, you've created an account!"
    end

    def self.username_creation
        test_name = User.first.username
        while User.find_by(username: test_name)
            test_name = prompt.ask("Please enter a username:")
            if User.find_by(username: test_name)
                puts "That username already exists, please choose another."
            end
        end
        return test_name
    end

    def self.username_check
        username = nil
        while !User.find_by(username: username)
            username = prompt.ask("Username:")
            if !User.find_by(username: username)
                puts "That user name does not exit. Please try another."
            end
        end
        return username
    end

end
