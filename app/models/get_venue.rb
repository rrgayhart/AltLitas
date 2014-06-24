class GetVenue
  attr_reader :url, :type

  def initialize(details, type)
    @url = UrlFormatter.new(details, type).url
    @type = type
  end

  def get_foursquare_response
    response = Faraday.get(url)
    JSON.parse(response.body)
  end

  def sanitize_query_array(response)
    suggestions = response['response']['groups'].first['items'] rescue {}
    sanitized = suggestions.collect do |suggestion|
      venue = suggestion['venue']
      why = suggestion['reasons']['items'][0]["summary"] rescue nil
      sayWhat = suggestion['tips'][0]['text'] rescue 'nothing'
      who = suggestion['tips'][0]['user']['firstName'] rescue 'some rando'
      soundsLike = who + " says " + sayWhat
      {
        name: venue['name'],
        why: why,
        url: venue['url'],
        location: venue['location'],
        who: soundsLike
      }
    end
    sanitized.select { |v| v[:why] }
  end

  def sanitize_venue_array(response)
    suggestions = response['response']['groups'][0]['items'] rescue {}
    suggestions.collect do |suggestion|
      venue = suggestion['venue']
      {
        name: venue['name'],
        url: venue['url'],
        location: venue['location'],
      }
    end
  end

  def generate_response_array(data)
    case type
    when 'require'
      sanitize_query_array(data)
    when 'food'
      sanitize_venue_array(data)
    when 'booze'
      sanitize_venue_array(data)
    else
      ['nope']
    end
  end

  def result
    response = get_foursquare_response
    generate_response_array(response).sample
  end

end
