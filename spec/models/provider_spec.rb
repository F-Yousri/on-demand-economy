require 'rails_helper'

RSpec.describe Provider, type: :model do
  it { should validate_presence_of(:url) }
  it { should validate_presence_of(:name) }
end
