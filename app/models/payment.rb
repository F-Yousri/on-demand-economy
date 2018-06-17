class Payment < ApplicationRecord
    validates :name,:status, presence: true
    mount_uploader :image, GlobalUploader
end
