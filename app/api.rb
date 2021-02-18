require 'open-uri'
require 'net/http'
require 'json'
require 'pry'

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

    #Gets API Endpoint
    def response
        url = construct_url
        uri = URI.parse(url)
        response = Net::HTTP.get_response(uri)
        response.body
    end

    #Parses JSON Into Object
    def data
        construct_url
        JSON.parse(response)
    end

    # ------ EXAMPLE DATA BEGIN ------
    # {"coord"=>{"lon"=>-82.9988, "lat"=>39.9612},
    #  "weather"=>[{"id"=>800, "main"=>"Clear", "description"=>"clear sky", "icon"=>"01n"}],
    #  "base"=>"stations",
    #  "main"=>{"temp"=>7.72, "feels_like"=>-1.07, "temp_min"=>3.99, "temp_max"=>12.2, "pressure"=>1024, "humidity"=>79},
    #  "visibility"=>10000,
    #  "wind"=>{"speed"=>4.61, "deg"=>290},
    #  "clouds"=>{"all"=>1},
    #  "dt"=>1613532772,
    #  "sys"=>{"type"=>1, "id"=>3656, "country"=>"US", "sunrise"=>1613478202, "sunset"=>1613516941},
    #  "timezone"=>-18000,
    #  "id"=>4509177,
    #  "name"=>"Columbus",
    #  "cod"=>200}
    # ------ EXAMPLE DATA END ------

    def current_weather
        wind_speed = data["wind"]["speed"]
        case wind_speed
        when 0..1.5
            wind_speed = "no wind."
        when 1.6..7
            wind_speed = "light wind"
        when 7.1..18
            wind_speed = "moderate wind"
        when 18.1..35
            wind_speed = "strong wind"
        when 35..300
            wind_speed = "very strong wind"
        end
        puts "It is currently #{data["main"]["temp"].round}℉ in #{city}."
        puts "Today's high is #{data["main"]["temp_max"].round}℉, with a low of #{data["main"]["temp_min"].round}℉"
        puts "You can expect #{data["weather"][0]["description"]} today with #{wind_speed}."
    end

    def valid_city
        data["cod"] == 200
    end

end

# ------- EXAMPLE CALLS ------- 
# columbus = Weather.new("Columbus")
# boulder = Weather.new("Boulder")
# los_angeles = Weather.new("Los Angeles")
# corvallis = Weather.new("Corvallis")
# Milan = Weather.new("Milan")
# fake_city = Weather.new("Fake city 123")
# ------- END EXAMPLE CALLS ------- 