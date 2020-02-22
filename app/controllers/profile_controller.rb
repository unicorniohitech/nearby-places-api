
class ProfileController < ApplicationController
    before_action :authorize_request
        
    def index
        @response = Profile.new(@current_user.id)
        @response.prepare_profile

        respond
    end

    private

    def respond
        p "respond-------------------------------------"
        if @response
            render json: @response, status: 200
        else
            render json: { errors: @response.errors }, status: 403
        end
    end

    def user_params
        params.permit(
        :name, :email, :password, :password_confirmation
        )
    end
end
  