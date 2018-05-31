class UsersController < ApplicationController

  before_action :authorize_request, except: :create
  before_action :is_verified, except: [:verify, :create]
  # POST /signup
  # return authenticated token upon signup
  def create
    verificationCode=rand(9999)
    user = User.new(user_params)
    user.user_pin=verificationCode
    user.save
    # client = Twilio::REST::Client.new('sid', 'token')
    #     client.api.account.messages.create(
    #       from: 'sender number',
    #       to: '+2'+user.phone,
    #       body: "Thanks #{user.name} for signing up. Your Verification Code is #{verificationCode} . \n "
    #     )
    auth_token = AuthenticateUser.new(user.email, user.password).call
    response = { message: Message.account_created, auth_token: auth_token, user: user }
    json_response(response, :created)
  end

  def test
    json_response("test_function")
  
  end

  def verify 
    
    if ((params[:verification_pin].to_i) == @current_user.user_pin)
      user = User.find_by(id: @current_user.id)
      user.verified = true
      user.save()
      json_response(user)
    elsif
      json_response("incorrect varification code")
    end
  end

  private

  def user_params
    params.permit(
      :name,
      :email,
      :password,
      :password_confirmation,
      :phone,
      :verified,
      :verification_pin
    )
  end
end
