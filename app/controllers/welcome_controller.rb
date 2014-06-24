class WelcomeController < ApplicationController

  def index
    venue = GetVenue.new
    render json: venue.random_venue
  end

  def booze
    venue = GetVenue.new
    render json: venue.random_booze
  end

  def i_require
    venue = GetVenue.new
    render json: venue.i_require_random(params['term'])
  end

end
