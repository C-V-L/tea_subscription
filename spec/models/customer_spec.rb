require 'rails_helper'

RSpec.describe Customer, type: :model do
  context 'validations' do
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name)}
    it { should validate_presence_of(:email)}
    it { should validate_presence_of(:address)}
    it { should validate_uniqueness_of(:email)}
  end

  context 'relationships' do
    it { should have_many(:subscriptions) }
    it { should have_many(:subscription_teas).through(:subscriptions) }
    it { should have_many(:teas).through(:subscription_teas) }
  end
end
