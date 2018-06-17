class AuthenticationController < ApplicationController
  # return auth token once user is authenticated
  before_action :authorize_request, except: :authenticate

  def authenticate
     
    auth_token =AuthenticateUser.new(auth_params[:email], auth_params[:password]).call

    user=User.find_by_email(auth_params[:email])
    if user.verified

    response={ message: Message.success, auth_token: auth_token, user: {name: user.name, email: user.email, phone: user.phone, avatar: user.avatar} }
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
