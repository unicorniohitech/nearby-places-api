class Api::V1::RatingsController < ApplicationController
    before_action :authorize_request
    before_action :find_rating, only: [:create, :index]

    def index
        @ratings = Rating.where(place_id: params[:place_id]).return_data
        render json: @ratings, status: :ok
    end
    
    def new
        @rating = Rating.new
    end

    def create
        @rating = Rating.new(rating_params)
        @rating.user_id = @current_user.id

        if @rating.save
            render json: @rating, status: :created 
        else
            render json: { errors: @rating.errors.full_messages },
                status: :unprocessable_entity
        end
    end

    def show
        @ratings = Rating.where("ratings.id = (?)", params[:id]).return_data
        render json: @ratings, status: :ok
    end

    def destroy
        
    end

    private

    def rating_params
        params.permit(:comment, :score, :place_id)
    end

    def find_rating
        @rating = Rating.find_by_id(params[:place_id])
    end
    
end
    