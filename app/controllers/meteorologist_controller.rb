require 'open-uri'

class MeteorologistController < ApplicationController
  def street_to_weather_form
    # Nothing to do here.
    render("street_to_weather_form.html.erb")
  end

  def street_to_weather
    @street_address = params[:user_street_address]
    url_safe_street_address = URI.encode(@street_address)

    # ==========================================================================
    # Your code goes below.
    # The street address the user input is in the string @street_address.
    # A URL-safe version of the street address, with spaces and other illegal
    #   characters removed, is in the string url_safe_street_address.
    # ==========================================================================

url = "http://maps.googleapis.com/maps/api/geocode/json?address="+url_safe_street_address
raw_data = open(url).read
parsed_data = JSON.parse(open(url).read)



    @latitude = parsed_data["results"][0]["geometry"]["location"]["lat"].to_s

    @longitude = parsed_data["results"][0]["geometry"]["location"]["lng"].to_s



site = "https://api.forecast.io/forecast/02796f556f4ba1e77a89c451177de593/"+@latitude+","+@longitude

val = JSON.parse(open(site).read)


    @current_temperature = val["currently"]["temperature"]

    @current_summary = val["currently"]["summary"]

    @summary_of_next_sixty_minutes = val["minutely"]["summary"]

    @summary_of_next_several_hours = val["hourly"]["summary"]

    @summary_of_next_several_days = val["daily"]["summary"]
    render("street_to_weather.html.erb")
  end
end
