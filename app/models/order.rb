class Order < ApplicationRecord
    validates_presence_of :from, :to, :provider_id,:images
    mount_uploaders :images, ImagesUploader


end
