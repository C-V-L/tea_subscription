require "rails_helper"

describe "Subscriptions API" do
  before :each do
    @customer = create(:customer)
    @tea = create(:tea)
  end

  describe "create a subscription" do
    describe "happy path" do
      it 'can create a subscription' do
        post '/api/v1/subscriptions', params: { customer_id: @customer.id, tea_id: @tea.id, price: 1.5, frequency: "weekly" }

        expect(response).to be_successful
        subscription = JSON.parse(response.body, symbolize_names: true)
        expect(subscription[:data][:attributes][:customer_id]).to eq(@customer.id)
        expect(subscription[:data][:attributes][:tea_id]).to eq(@tea.id)
        expect(subscription[:data][:attributes][:price]).to eq(1.5)
        expect(subscription[:data][:attributes][:status]).to eq("active")
        expect(subscription[:data][:attributes][:frequency]).to eq("weekly")
      end
    end

    describe "sad path" do
      it 'returns an error if customer_id is missing' do
        post '/api/v1/subscriptions', params: { tea_id: @tea.id, price: 1.5, frequency: "weekly" }
        
        error = JSON.parse(response.body, symbolize_names: true)
        expect(error[:errors][0][:status]).to eq(404)
        expect(error[:errors][0][:title]).to eq("Validation failed: Customer can't be blank, Customer must exist")
      end
    end
  end
end