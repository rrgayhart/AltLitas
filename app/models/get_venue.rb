class GetVenue

  def random_venue
    endpoint = create_endpoint(boulder_office_location, food_now_details)
    response = get_foursquare_response(endpoint)
    sanitized_array = parse_response(response)
    sanitized_array.sample
  end

  def random_booze
    endpoint = create_endpoint(boulder_office_location, booze_now_details)
    response = get_foursquare_response(endpoint)
    sanitized_array = parse_response(response)
    sanitized_array.sample
  end

  def token_data
    "&client_id=#{ENV['fs_client_id']}&client_secret=#{ENV['fs_client_secret']}&v=#{Time.now.strftime('%Y%m%d')}"
  end

  def boulder_office_location
    "ll=40.016835,-105.283404"
  end

  def food_now_details
    "&section=food&openNow=true&sortByDistance=true&specials=false&radius=2000&limit=50"
  end

  def booze_now_details
    "&section=drinks&openNow=true&sortByDistance=true&specials=false&radius=2000&limit=50"
  end

  def base_url
    "https://api.foursquare.com/v2/venues/explore?"
  end

  def create_endpoint(location, details)
    base_url + location + details + token_data
  end

  def get_foursquare_response(endpoint)
    response = Faraday.get(endpoint)
    JSON.parse(response.body)
  end

  def parse_response(output)
    suggestions = output['response']['groups'][0]['items'] rescue {}
    sanitize_venue_array(suggestions)
  end

  def sanitize_venue_array(suggestions)
    suggestions.collect do |suggestion|
      venue = suggestion['venue']
      {
        name: venue['name'],
        url: venue['url'],
        location: venue['location'],
      }
    end
  end
end
