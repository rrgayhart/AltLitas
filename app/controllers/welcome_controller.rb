class WelcomeController < ApplicationController

  def index
    response = GetVenue.new("", 'food')
    render json: response.result
  end

  def food
    response = GetVenue.new(params['details'] || "", 'food')
    render json: response.result
  end

  def booze
    response = GetVenue.new(params['details'] || "", 'booze')
    render json: response.result
  end

  def i_require
    response = GetVenue.new(params['details'] || "", 'require')
    render json: response.result
  end

end
