class Provider < ApplicationRecord
    validates :name,:url,:image, :rate,presence: true
    mount_base64_uploader :image, ImagesUploader

end
