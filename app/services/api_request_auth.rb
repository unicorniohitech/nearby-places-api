class ApiRequestAuth
  prepend SimpleCommand

  def initialize(headers = {})
    @headers = headers
  end

  def call
    user
  end

  private

  attr_reader :headers

  def user
    @user ||= User.find(decoded_auth_token[:user_id]) if decoded_auth_token
    @user || errors.add(:token, 'Invalid token') && nil
  end

  def decoded_auth_token
    @decoded_auth_token ||= JsonWebToken.decode(http_auth_header)
  end

  def http_auth_header
    if headers['Authorization'].present?
      return verify_token(headers['Authorization']) ? headers['Authorization'].split(' ').last : false
    else
      errors.add(:token, 'Missing token')
    end
    nil
  end

  def verify_token(token)
    jwt = ValidateJwtToken.where(token: token).present?

    return !jwt
  end
end