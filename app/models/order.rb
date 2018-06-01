class Order < ApplicationRecord
    validates_presence_of :from, :to, :provider_id,:payment_method
    mount_uploaders :images, ImagesUploader


end
