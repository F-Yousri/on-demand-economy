class Provider < ApplicationRecord
    validates :name,:url,:image, :rate ,:login_url,:secret_key ,presence: true
    mount_uploader :image, GlobalUploader

end
