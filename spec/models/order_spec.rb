require 'rails_helper'

RSpec.describe Order, type: :model do

  # ensure name, email and password_digest are present before save
  it { should validate_presence_of(:images) }
  it { should validate_presence_of(:from) }
  it { should validate_presence_of(:to) }
  it { should validate_presence_of(:provider_id) }

end
