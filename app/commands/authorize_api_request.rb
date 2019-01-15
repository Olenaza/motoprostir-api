class AuthorizeApiRequest
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
    @user || errors.add(:token, 'invalid token') && nil
  end

  def decoded_auth_token
    @decoded_auth_token ||= JsonWebToken.decode(token)
  end

  def token
    if headers['Authorization'].present?
      return headers['Authorization'].split(' ').last
    else
      errors.add(:token, 'Missing token')
    end
    nil
  end
end