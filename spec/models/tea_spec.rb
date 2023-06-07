require 'rails_helper'

RSpec.describe Tea, type: :model do
  context 'validations' do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:description)}
    it { should validate_presence_of(:temp)}
    it { should validate_presence_of(:brew_time)}
  end
  
  context 'relationships' do
    it { should have_many(:subscriptions) }
    it { should have_many(:customers).through(:subscriptions) }
  end
end
