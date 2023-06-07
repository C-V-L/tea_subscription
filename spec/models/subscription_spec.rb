require 'rails_helper'

RSpec.describe Subscription, type: :model do
  context 'validations' do
    it { should validate_presence_of(:price)}
    it { should validate_presence_of(:status)}
    it { should validate_presence_of(:frequency)}
  end
  
  context 'relationships' do
    it { should belong_to(:customer) }
    it { should belong_to(:tea) }
  end
end
