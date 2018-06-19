class Message
  def self.not_found(record = 'record')
    "Sorry, #{record} not found."
  end

  def self.invalid_credentials
    'Invalid credentials'
  end

  def self.invalid_token
    'Invalid token'
  end

  def self.missing_token
    'Missing token'
  end

  def self.unauthorized
    'Unauthorized request'
  end

  def self.account_created
    'Account created successfully'
  end

  def self.account_not_created
    'Account could not be created'
  end

  def self.expired_token
    'Sorry, your token has expired. Please login to continue.'
  end

  def self.forgot_password_request
    'Kindly check your mail to reset your password'
  end

  def self.account_not_verified
    'sorry this account is not yet verified'
  end

  def self.phone_already_exists
    'sorry this phone already taken'
  end

  def self.email_already_exists
    'sorry this email already taken'
  end

  def self.success
    'success'
  end

  def self.incorrect_verification_code
  'incorrect verification code'
  end
  
  def self.error_while_changing_password
    'error while changing password'
  end

  def self.error_while_updating_profile
    'Email or Phone already exists'
  end

  def self.carrier_not_ready

    "carrier can't take your order" 
  end

  def self.about_us
    'Driveo App
    app desription here '
  end

  def self.already_verified

    'you are already verified'
  end

  def self.email_not_found
    'incorrect email address'
  end

  def self.password_doesnot_match
    "Password Doesn't match"
  end

  def self.old_password_doesnot_match
    "current password doesn't match"
  end

  def self.order_time_error
    'Order Time Error'
  end
end
