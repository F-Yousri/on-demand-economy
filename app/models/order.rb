class Order < ApplicationRecord
    validates_presence_of :src_latitude,:src_longitude,:dest_latitude,:dest_longitude,:title, :provider_id,:payment_method
    mount_uploader :images, ImagesUploader


end
