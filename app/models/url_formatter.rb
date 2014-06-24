class UrlFormatter
  attr_reader :details, :type

  def initialize(details, type)
    @details = parse_details(details)
    @type = type
  end

  def parse_details(details)
    details = details.split('&')
    {
      terms: details[0],
      location: details[1]
    }
  end

  def translate_location
    city = details[:location]
    if city && city != 'boulder'
      case city.downcase
      when 'portland'
        portland_office_location
      else
        "near=#{city}"
      end
    else
      boulder_office_location
    end
  end

  def translate_terms
    if details[:terms]
      '&' + details[:terms]
    end
  end

  def translate_type
    case type
      when 'food'
        "&section=food&openNow=true&sortByDistance=true&specials=false&radius=2000&limit=50"
      when 'booze'
        "&section=drinks&openNow=true&sortByDistance=true&specials=false&radius=2000&limit=50"
      when 'require'
        "&query=#{translate_terms}&sortByDistance=true&specials=false&radius=20000&limit=25"
    end
  end

  def url
    base_url + translate_location + translate_type + token_data
  end

  def base_url
    "https://api.foursquare.com/v2/venues/explore?"
  end

  def boulder_office_location
    "ll=40.016835,-105.283404"
  end

  def portland_office_location
    "ll=45.522768,-122.6601628"
  end

  def token_data
    "&client_id=#{ENV['fs_client_id']}&client_secret=#{ENV['fs_client_secret']}&v=#{Time.now.strftime('%Y%m%d')}"
  end

end
