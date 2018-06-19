# frozen_string_literal: true

class User < ApplicationRecord
  # encrypt password
  has_secure_password

 
  # Validations
  validates_presence_of :password_digest, :phone, :email
  validates :phone, uniqueness: true
  validates :email, uniqueness: true
  validates_format_of :email, :with =>/[a-zA-Z0-9]+@[a-zA-Z]+\..+/i	
  validates_format_of :phone, { with: /[0-9]{11,12}\z/,message: 'Is Invalid'}
  mount_uploader :avatar, GlobalUploader
  
end
