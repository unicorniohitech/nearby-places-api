class AuthenticationController < ApplicationController
  before_action :authorize_request, except: [:login, :logout]

  def login
    access = AuthenticateAccess.call(params[:email], params[:password])
    user = User.find_by_email(params[:email])
    time = Time.now + 24.hours.to_i
    
    if access.success?
      render json: { name: user.name, email: user.email,
      token: access.result, message: 'Login success!',
      exp: time.strftime("%m-%d-%Y %H:%M") },
      status: :ok
      ValidateJwtToken.create(token: access.result)
    else
      render json: { error: access.errors }, status: :unauthorized
    end
  end

  def logout
    revoke = ValidateJwtToken.find_or_create_by(token: request.headers['Authorization'])
    if revoke
      render json: { message: 'Logout sucessfull!' }, status: :ok
    else
      render json: { error: 'Invalid credentials!' }, status: :unauthorized
    end
  end

  private

  def login_params
    params.permit(:email, :password)
  end
end