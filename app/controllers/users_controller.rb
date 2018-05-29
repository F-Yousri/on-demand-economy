class UsersController < ApplicationController
  skip_before_action :authorize_request, only: :create
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

  private

  def user_params
    params.permit(
      :name,
      :email,
      :password,
      :password_confirmation,
      :phone
    )
  end
end
