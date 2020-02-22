
class Api::V1::PlacesController < ApplicationController
    before_action :authorize_request
    before_action :find_place, except: %i[create index]
      
    def index
      case params[:type]
      when 'list'
        @response = Api::V1::ListPlaces.new()
        @response.prepare_list
      when 'map'
        @response = Api::V1::MapPlaces.new(params[:latitude], params[:longitude])
        @response.prepare_map
      end

      respond
    end
  
    def show
      render json: @place, status: :ok
    end
    
    def create
      @place = Place.new(place_params)
      @place.user_id = @current_user.id

      if @place.save
        render json: @place, status: :created 
      else
        render json: { errors: @place.errors.full_messages },
               status: :unprocessable_entity
      end
    end
    
    def update
      unless @place.update(place_params)
        render json: { errors: @place.errors.full_messages },
               status: :unprocessable_entity
      end
    end
    
    def destroy
      @place.destroy
    end
  
    private

    def respond
      if @response
        render json: @response, status: 200
      else
        render json: { errors: @response.errors }, status: 403
      end
    end
  
    def find_place
      @place = Place.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        render json: { errors: 'Place not found' }, status: 403
    end
  
    def place_params
      params.permit(
        :name, :cnpj, :address, :latitude, :longitude, :city, :state_code, :country
      )
    end
  end
    