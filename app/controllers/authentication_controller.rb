class AuthenticationController < ApplicationController
  # return auth token once user is authenticated
  before_action :authorize_request, except: :authenticate

  def authenticate
    if User.find_by_email(auth_params[:email]).verified == true 
    auth_token =AuthenticateUser.new(auth_params[:email], auth_params[:password]).call
    response={ message: Message.success, auth_token: auth_token }
    else 
    response={message: Message.un_verified_user}
    end
    json_response(response)
  end

  private

  def auth_params
    params.permit(:email, :password)
  end
end
