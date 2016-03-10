require "./lib/geolocation"
require "sinatra/base"
require "json"
require "httparty"
require "pry"
require "dotenv"
Dotenv.load

class Dashboard < Sinatra::Base
  get("/") do
    @ip = request.ip
    @geolocation = Geolocation.new(@ip)
    erb :dashboard

    latitude = @geolocation.latitude
    longitude = @geolocation.longitude
    weather_key = ENV["DARKSKY_API_KEY"]

    url=("https://api.forecast.io/forecast/#{weather_key}/#{latitude},#{longitude}")

    response = HTTParty.get(url)
    @weather_data = JSON.parse(response.body)["currently"]
  end
end
