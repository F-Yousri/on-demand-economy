# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :authorize_request, except: %i[create forgot_password reset_password reset_password_mob about_us]
  before_action :is_verified, except: %i[verify create forgot_password reset_password reset_password_mob about_us resend_verification]
  before_action :check_duplication , only: :update
  # POST /signup
  # return authenticated token upon signup
    
  def show 
    user=current_user
    json_response(user)
  end
  def create
    verificationCode = rand(1000..9999)
    user = User.create!(user_params)
    user.user_pin = verificationCode

     if user.save
      UserMailer.registeration_confirmation(user).deliver_now
      # client = Twilio::REST::Client.new(Rails.application.secrets.sms_sid, Rails.application.secrets.sms_token)
      #   client.api.account.messages.create(
      #     from: Rails.application.secrets.sms_sender,
      #     to: '+2'+user.phone,
      #     body: "Thanks #{user.name} for signing up. Your Verification Code is #{verificationCode} . \n "
      #     )
      auth_token = AuthenticateUser.new(user.email, user.password).call
      response = { message: Message.success, auth_token: auth_token, user: user }
     end
    json_response(response)
  end

  def verify
    response ={}
    if params[:verification_pin].to_i == current_user.user_pin
      user = User.find_by(id: current_user.id)
      user.verified = true
      user.save
      response = { message: Message.success}
    else
      response = { message: Message.incorrect_verification_code}
    end
    json_response(response)
  end

  def resend_verification 
    user = User.find_by(id: current_user.id)
    verificationCode = rand(1000..9999)
    user.user_pin = verificationCode
    if user.save
      # client = Twilio::REST::Client.new(Rails.application.secrets.sms_sid, Rails.application.secrets.sms_token)
      #   client.api.account.messages.create(
      #     from: Rails.application.secrets.sms_sender,
      #     to: '+2'+user.phone,
      #     body: "Thanks #{user.name} for signing up. Your New Verification Code is #{verificationCode} . \n "
      #     )
      response={message: Message.success,user:user}
    end
      json_response(response)
  end

  def update
    user=current_user
    if user.update(user_params)
    response = { message: Message.success,user: user}
    else
      response = { message:Message.error_while_updating_profile}
    end
    json_response(response)
  end

  def forgot_password
    @user = User.find_by_email(params[:email])
    reset_token=JsonWebToken.encode_reset_password(user_id: @user.id)
    UserMailer.forgot_password(@user, reset_token).deliver_now
    respone = { message: Message.forgot_password_request}
    json_response(respone)
  end

  def reset_password
    @reset_token = JsonWebToken.decode(params[:hash])
    @user = User.find(@reset_token[:user_id])
    @user.password = params[:password]
    @message = if @user.save
                  Message.success
               else
                  Message.error_while_changing_password
                end
    json_response(message: @message)
  end

  def reset_password_mob
    @reset_token = params[:hash]
    @mobile_reset_link="Driveo://driveo.herokuapp.com/api/v1/authentication/resetpassword?hash=#{@reset_token}"
    redirect_to @mobile_reset_link
  end

  def change_password
    user=User.find(current_user.id)
   if BCrypt::Password.new(user.password_digest)==params[:password]
    user.password=params[:new_password]
    user.save
    response = { message: Message.success}
    else
      response={message: Message.error_while_changing_password}
    end
    json_response(response)
  end

  def check_duplication
    if User.find_by_email(user_params[:email])
      json_response({ message: Message.email_already_exists})
    elsif User.find_by_phone(user_params[:phone])
      json_response({ message: Message.phone_already_exists})  
    end
  end

  def about_us
    response={message: Message.success,about_us: Message.about_us}
    json_response(response)
  end

  private

  def user_params
    params.permit(:name,:email,:password,:new_password,:phone,:verified,:verification_pin,:avatar)
  end
end