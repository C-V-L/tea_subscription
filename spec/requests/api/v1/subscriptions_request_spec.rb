require "rails_helper"

describe "Subscriptions API" do
  before :each do
    @customer = create(:customer)
    @tea = create(:tea)
    @subscription = create(:subscription, customer_id: @customer.id, tea_id: @tea.id)
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

      it 'defaults status and frequency if not provided' do
        post '/api/v1/subscriptions', params: { customer_id: @customer.id, tea_id: @tea.id, price: 1.5 }
        subscription = JSON.parse(response.body, symbolize_names: true)
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

      it 'returns an error if tea_id is missing' do
        post '/api/v1/subscriptions', params: { customer_id: @customer.id, price: 1.5, frequency: "weekly" }
        error = JSON.parse(response.body, symbolize_names: true)
        expect(error[:errors][0][:status]).to eq(404)
        expect(error[:errors][0][:title]).to eq("Validation failed: Tea must exist")
      end

      it 'returns an error if price is missing' do
        post '/api/v1/subscriptions', params: { customer_id: @customer.id, tea_id: @tea.id, frequency: "weekly" }
        error = JSON.parse(response.body, symbolize_names: true)
        expect(error[:errors][0][:status]).to eq(404)
        expect(error[:errors][0][:title]).to eq("Validation failed: Price can't be blank")
      end
    end
  end

  describe "update a subscription" do
    describe "happy path" do
      it "can update a subscription's status" do
        patch "/api/v1/subscriptions/#{@subscription.id}", params: { status: "cancelled"}

        subscription = JSON.parse(response.body, symbolize_names: true)
        expect(subscription[:data][:attributes][:status]).to eq("cancelled")
      end

      it 'can update a subscriptions frequnecy' do
        expect(@subscription[:frequency]).to eq("biweekly")
        patch "/api/v1/subscriptions/#{@subscription[:id]}", params: { frequency: "monthly"}

        subscription = JSON.parse(response.body, symbolize_names: true)
        expect(subscription[:data][:attributes][:frequency]).to eq("monthly")
      end
    end
  end
end