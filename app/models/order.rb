class Order < ApplicationRecord
    validates_presence_of :from, :to, :provider_id,:payment_method
    # mount_uploader :images, ImagesUploader


end
