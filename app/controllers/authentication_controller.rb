class AuthenticationController < ApplicationController
  # return auth token once user is authenticated
  before_action :authorize_request, except: :authenticate

  def authenticate
     
    auth_token =AuthenticateUser.new(auth_params[:email], auth_params[:password]).call

    if User.find_by_email(auth_params[:email]).verified == true
    response={ message: Message.success, auth_token: auth_token }
    else 
    response={message: Message.account_not_verified,auth_token: auth_token}
    end
    json_response(response)
  end

  private

  def auth_params
    params.permit(:email, :password)
  end
end
