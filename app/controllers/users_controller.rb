
class UsersController < ApplicationController
  before_action :authorize_request, except: :create
  before_action :find_user, except: %i[create index]
    
  def index
    @users = User.all
    render json: @users, status: :ok
  end

  def show
    user = User.return_data(params[:id])
    if user
      render json: user, status: :ok
    else
      render json: { errors: 'User not found' }, status: 403
    end
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      render json: @user, status: :created 
    else
      render json: { errors: @user.errors.full_messages },
             status: :unprocessable_entity
    end
  end
  
  def update
    unless @user.update(user_params)
      render json: { errors: @user.errors.full_messages },
             status: :unprocessable_entity
    end
  end
  
  def destroy
    @user.destroy
  end

  private

  def find_user
    @user = User.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      render json: { errors: 'User not found' }, status: 403
  end

  def user_params
    params.permit(
      :name, :email, :password, :password_confirmation
    )
  end
end
  