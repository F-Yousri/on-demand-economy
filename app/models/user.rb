class User < ApplicationRecord
  # encrypt password
  has_secure_password

  # Validations
  validates_presence_of :name, :email, :password_digest
  validates :email , :phone , uniqueness: true
end
