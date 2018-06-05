class AuthenticationController < ApplicationController
  # return auth token once user is authenticated
  before_action :authorize_request,:is_verified, except: :authenticate

  def authenticate
    auth_token =AuthenticateUser.new(auth_params[:email], auth_params[:password]).call
    response={ message: Message.success, auth_token: auth_token }
    json_response(response)
  end

  private

  def auth_params
    params.permit(:email, :password)
  end
end
