require_relative "api.rb"

class Cli 
    def self.prompt
        @@PROMPT = TTY::Prompt.new
    end

    def self.run
        puts "Hello, welcome to the weather app."
        account_check = prompt.yes?("Do you have an account?")
        if account_check
            login
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

    def self.login
        username = username_check
            $user = User.find_by(username: username)
            password = nil
            while $user.password != password
                password = prompt.mask("Password:")
                if $user.password != password
                    puts "Please try again."
                end
            end
            puts "Success."
            $user
            menu
    end

    def self.menu
        select = prompt.select("What would you like to do:", ["Add New City", "See Your Cities", "Remove a City", "Logout"])
        case select
        when "Add New City"
            add_new_city $user
        when "See Your Cities"
            view_favorite_cities $user
        when "Remove a City"
            remove_a_favorite_city $user
        when "Logout"
            logout
        end
    end

    def self.add_new_city user
        new_city = nil
        while !City.find_by(name: new_city)
            new_city = prompt.ask("Which city would you like to add:")
            if City.find_by(name: new_city)
                city = City.find_by(name: new_city)
                FavoriteCity.create(user: user, city: city)
                puts "You've added #{city.name} to your favorite cities!"
                menu
            end
            if !City.find_by(name: new_city)
                api_call = Weather.new(new_city).valid_city
                if api_call
                    city = City.create(name: new_city)
                    FavoriteCity.create(user: user, city: city)
                    puts "You've added #{city.name} to your favorite cities!"
                    menu
                else
                    puts "Sorry, we couldn't find that city."
                    puts "Please try again."
                    add_new_city $user
                end
            end
        end
    end

    def self.view_favorite_cities user
        # binding.pry
        cities_array = User.find(user.id).cities.map do |city|
            city.name
        end
        selected_city = prompt.select("Select your city:", cities_array)
        Weather.new(selected_city).current_weather
        selection = prompt.select(nil, ["See more cities", "Return to menu"])
        case selection
        when "See more cities"
            view_favorite_cities $user
        when "Return to menu"
            menu
        end
    end
    
    def self.remove_a_favorite_city user
        cities_array = User.find(user.id).cities.map do |city|
            city.name
        end
        selected_city = prompt.select("Select a city to delete:", cities_array)
        selected_city_2 = City.find_by(name: selected_city) 
        deleted_selected_city = FavoriteCity.where(user_id: user.id, city: selected_city_2.id)
        FavoriteCity.destroy(deleted_selected_city[0].id)
        menu
    end
    
    def self.logout
        exit!
    end

end