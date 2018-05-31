# frozen_string_literal: true

class UsersController < ApplicationController
  skip_before_action :authorize_request, only: %i[create forgot_password reset_password]
  before_action :is_verified, except: %i[verify create forgot_password reset_password]
  # POST /signup
  # return authenticated token upon signup
  def create
    verificationCode = rand(9999)
    user = User.new(user_params)
    user.user_pin = verificationCode
    user.save
    UserMailer.registeration_confirmation(user).deliver_now
    # client = Twilio::REST::Client.new(Rails.application.secrets.sms_sid,Rails.application.secrets.sms_token)
    #     client.api.account.messages.create(
    #       from: Rails.application.secrets.sms_sender,
    #       to: '+2'+user.phone,
    #       body: "Thanks #{user.name} for signing up. Your Verification Code is #{verificationCode} . \n "
    #     )

    auth_token = AuthenticateUser.new(user.email,user.password).call
    response = { message: Message.account_created, auth_token: auth_token, user: user }
    json_response(response, :created)
  end

  def test
    json_response('test_function')
  end

  def verify
    if params[:verification_pin].to_i == @current_user.user_pin
      user = User.find_by(id: @current_user.id)
      user.verified = true
      user.save
      json_response(user)
    elsif
      json_response('incorrect varification code')
    end
  end


  def forgot_password
    @user = User.find_by_email(params[:email])
    reset_token=JsonWebToken.encode(user_id: @user.id)
    UserMailer.forgot_password(@user, reset_token).deliver_now
    @respone = { message: Message.forgot_password_request, reset_token: reset_token }
    json_response @respone
  end

  def reset_password
    @reset_token = JsonWebToken.decode(params[:hash])
    @user = User.find(@reset_token[:user_id])
    @user.password = params[:password]
    @message = if @user.save
                 'Password Succesffuly Changed'
               else
                 'Error While Changing Password'
                end
    json_response(user: @user, message: @message)
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
