class Order < ApplicationRecord
    validates_presence_of :from, :to, :provider_id

end
