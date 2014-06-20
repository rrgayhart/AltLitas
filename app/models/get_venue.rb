class GetVenue

  def token_data
    "&client_id=#{APP_CONFIG['fs_client_id']}&client_secret=#{APP_CONFIG['fs_client_secret']}&v=#{Time.now.strftime('%Y%m%d')}"
  end

  def boulder_lat_lon
    "40.0176,-105.2797"
  end

  def boulder_office_lat_lon
    "40.016835,-105.283404"
  end

  def extra_deets
    "&section=food&openNow=true&sortByDistance=true&specials=false&radius=2000&limit=50"
  end

  def venue_url
    "https://api.foursquare.com/v2/venues/explore?ll=#{boulder_office_lat_lon}#{extra_deets}#{token_data}"
  end

  def get_venue_response
    response = Faraday.get(venue_url)
    JSON.parse(response.body)
  end

  def parse_response(output)
    suggestions = output['response']['groups'][0]['items']
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

  def random_venue
    sanitized_array = parse_response(get_venue_response)
    num = rand(0..49)
    sanitized_array[num]
  end

end
