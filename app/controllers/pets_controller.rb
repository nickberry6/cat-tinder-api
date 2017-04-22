class PetsController < ApplicationController
  def query_uri()
    URI("http://api.petfinder.com/pet.find?key=#{Rails.application.secrets.petfinder_api_key}&location=#{pets_params[:zip]}&format=json")
  end

  def query_pets
    response = Net::HTTP.get_response(query_uri)
    pets = JSON.parse(response.body)['petfinder']['pets']
    render json: pets, status: 200
  end

  def pets_params
    params.permit(:zip)
  end
end
