class WelcomeController < ApplicationController

  def index
    venue = GetVenue.new
    render json: venue.random_venue
  end

end
