class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.registeration_confirmation.subject
  #
  def registeration_confirmation(user)
    @user=user
    @url="https://minamon.herokuapp.com/auth/login"
    mail to: @user.email, subject: "Driveo Registeration" 
  end


  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.forgot_password.subject
  #
  def forgot_password(user,reset_token)
    @user=user
    @reset_token=reset_token
    # @url="https://minamon.herokuapp.com/reset_password/#{@reset_token}"
    @url="http://localhost:3000/reset_password/?hash=#{@reset_token}"
    mail to: @user.email, subject: "Driveo Reset Password"
  end
end
