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

  def self.incorrect_varification_code
  'incorrect verification code'
  end
  
  def self.error_wihle_changing_password
    'error while changing password'
  end
end
