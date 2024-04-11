require "http"
require "json"

map_key = ENV.fetch("GMAPS_KEY")
weather_key = ENV["PIRATE_WEATHER_API_KEY"]

pp "What's your location?"

loc = gets


map_url = "https://maps.googleapis.com/maps/api/geocode/json?address=#{loc}&key=#{map_key}"

raw_map = HTTP.get(map_url)
parsed_map= JSON.parse(raw_map)
loc_hash = parsed_map.fetch("results").at(0).fetch("geometry").fetch("location")
lat = loc_hash.fetch("lat")
lng = loc_hash.fetch("lng")


weather_url = "https://api.pirateweather.net/forecast/" + weather_key + "/" + lat.to_s + "," + lng.to_s

raw_weather = HTTP.get(weather_url)
parsed_weather = JSON.parse(raw_weather)
currently_hash = parsed_weather.fetch("currently")
current_temp = currently_hash.fetch("temperature")
hourly_hash = parsed_weather.fetch("hourly")
hourly_precip = hourly_hash.fetch("data")[1].fetch("precipProbability")

pp "The current temperature in #{loc} is #{current_temp}. There is a #{hourly_precip * 100}% chance of rain in the next hour."
