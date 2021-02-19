# Weather CLI
> A command line application that gives you the ability to create
> an account, track your favorite cities, and see their current 
> weather.

## Demo Video

[Weather CLI Video](https://www.youtube.com/)

## Technologies

* Ruby 2.6
* ActiveRecord 6.0
* Artii 2.1
* TTY-Prompt 0.23
* Openweather API - http://api.openweathermap.org

## Run This App

Feel free to fork our repo, clone it, and run our runner.rb file.

```ruby
ruby runner.rb
```

## Current Features

* Login
** Checks for unique usernames at the model level.
** Does live password validations.

* Add Favorite City
** Checks if city is available in OpenWeather's API
** Checks if city is already a City or Favorite Object

* See Cities
** Returns string interpolation of weather temps and conditions.
** Case/When statements & ternary statements handle grammar oddities.

* Remove Cities
** Removes Favorite Object, while maintaining City Object for other users.

* Logout
** Exits program.

## Code We're Proud Of

> We created a weather class that initializes a city property. With this class
> we can save an api call to our City objects and run easy to read class/instance
> methods on our Weather instance.

```ruby
class Weather
    attr_reader :city

    #API KEY & URL
    @@API_KEY = "&appid=bc012bd2022732de67c8d554fb7985cf"
    @@API_URL = "http://api.openweathermap.org/data/2.5/weather?units=imperial&q="

    #Initializes City Object
    def initialize city
        @city = city
    end

    #Creates API Endpoint URL
    def construct_url
        @@API_URL + city + @@API_KEY
    end

    #End of Sample
```

> This code executes when the user attempts to add a new favorite city. This code
> will first check if the city is already an object in our database, so that we
> don't create duplicate objects. Then the method will call our API to valid that
> this city is available in our API. Based on those conditionals, our method will
> then create a new object or return a friendly error message.

```ruby
    def self.add_new_city user
        new_city = nil
        while !City.find_by(name: new_city)
            new_city = prompt.ask("Which city would you like to add:")
            if City.find_by(name: new_city)
                city = City.find_by(name: new_city)
                user = User.find($user.id)
                if user.cities.any? { |city| city.name == new_city }
                    puts "It looks like you've already added this city."
                else
                FavoriteCity.create(user: user, city: city)
                puts "You've added #{city.name} to your favorite cities!"
                end
                menu
            end
            if !City.find_by(name: new_city)
                api_call = Weather.new(new_city).valid_city
                if api_call
                    city = City.create(name: new_city)
                    FavoriteCity.create(user: user, city: city)
                    menu
                else
                    puts "Sorry, we couldn't find #{new_city}."
                    puts "Please try again."
                    add_new_city $user
                end
            end
        end
    end
```
