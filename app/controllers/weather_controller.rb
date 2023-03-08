class WeatherController < ApplicationController
    def index
      if params[:city]
        @weather = get_weather(params[:city])
        puts "testing code ishan"
        # puts @weather.inspect
      end
    end
    
    private
    
    def get_weather(city)
      url = "http://api.openweathermap.org/data/2.5/weather?q=#{city}&appid=e7704bc895b4a8d2dfd4a29d404285b6"
      puts url
      response = HTTParty.get(url)
      puts "response bidy"
      puts response.body
      
      if response.code == 200
        json = JSON.parse(response.body)
        {
        name: json['name'],
        temperature: (json['main']['temp'] - 273.15).round(1),
        feels_like: (json['main']['feels_like'] - 273.15).round(1),
        description: json['weather'][0]['description'],
        pressure: json['main']['pressure'],
        humidity: json['main']['humidity'],
        wind_speed: json['wind']['speed'],
        wind_direction: json['wind']['deg'],
        sunrise: Time.at(json['sys']['sunrise']).strftime('%l:%M %p %Z'),
        sunset: Time.at(json['sys']['sunset']).strftime('%l:%M %p %Z'),
        temp_min:(json['main']['temp_min']-273.15).round(1),
        temp_max:(json['main']['temp_max']-273.15).round(1),
        visibility:json['visibility'],
        clouds:json['clouds']['all']
       
        }
      else
        nil
      end
    end
  end
  