class Provider < ApplicationRecord
    validates :name,:url,presence: true
end
