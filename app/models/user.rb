# frozen_string_literal: true

class User < ApplicationRecord
  # encrypt password
  has_secure_password

 
  # Validations
  validates_presence_of :password_digest, :phone, :email
  validates :phone, uniqueness: true
  validates :email, uniqueness: true
  mount_base64_uploader :avatar, ImagesUploader
  
end
