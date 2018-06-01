# frozen_string_literal: true

class User < ApplicationRecord
  # encrypt password
  has_secure_password

  # Validations
  validates_presence_of :password_digest, :phone, :email, presence: true
  validates :phone, uniqueness: { message: 'Phone Already Exists' }
  validates :email, uniqueness: { message: 'Email Already Exists' }
  
end
