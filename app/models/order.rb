class Order < ApplicationRecord
    paginates_per 3
    validates_presence_of :src_latitude,:src_longitude,:dest_latitude,:dest_longitude,:title, :provider_id,:payment_method,:weight
    validates :provider_id , :numericality => { :greater_than_or_equal_to => 1 }
    validates :weight , :numericality => { :greater_than_or_equal_to => 0.1 }
    mount_uploader :images, GlobalUploader

    def order_id
        self.order_id = self.id
    end

end
