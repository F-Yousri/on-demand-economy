# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :authorize_request, except: %i[create forgot_password reset_password reset_password_mob]
  before_action :is_verified, except: %i[verify create forgot_password reset_password reset_password_mob]
  before_action :check_duplication , only: :create
  # POST /signup
  # return authenticated token upon signup
    
  def create
    verificationCode = rand(9999)
    user = User.new(user_params)
    user.user_pin = verificationCode

    if user.save
      UserMailer.registeration_confirmation(user)
      # client = Twilio::REST::Client.new('sid', 'token')
      #   client.api.account.messages.create(
      #     from: 'sender number',
      #     to: '+2'+user.phone,
      #     body: "Thanks #{user.name} for signing up. Your Verification Code is #{verificationCode} . \n "
      #     )
    auth_token = AuthenticateUser.new(user.email, user.password).call
    response = { message: Message.success, auth_token: auth_token, user: user }
    end
    json_response(response, :created)
  end

  def verify
    response ={}
    if params[:verification_pin].to_i == @current_user.user_pin
      user = User.find_by(id: @current_user.id)
      user.verified = true
      user.save
      response = { message: Message.success}
      json_response(response)
    elsif
      response = { message: Message.incorrect_verification_code}
      json_response(response)
    end
  end

  def update
    user=User.update(current_user.id, email: params[:email], phone: params[:phone])
    response = { message: Message.success}
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
    respone = { message: Message.success}
    else
      respone={message: Message.error_while_changing_password}
    end
    json_response(respone)
  end


  def check_duplication
    if User.find_by_email(user_params[:email])
      json_response({ message: Message.email_already_exists})
    elsif User.find_by_phone(user_params[:phone])
      json_response({ message: Message.phone_already_exists})  
    end
  end

  def about_us
    response={message: Message.about_us}
    json_response(response)
  end

  private

  def user_params
    params.permit(
      :name,
      :email,
      :password,
      :new_password,
      :phone,
      :verification_pin
    )
  end
end
