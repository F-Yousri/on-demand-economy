class Provider < ApplicationRecord
    validates :name,:url,:image, presence: true
    mount_uploader :image, ImagesUploader

end
