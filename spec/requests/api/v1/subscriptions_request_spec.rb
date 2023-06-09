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
        sub_params = { customer_id: @customer.id, tea_id: @tea.id, price: 1.5, status: "active", frequency: "weekly" }
        post "/api/v1/customers/#{@customer.id}/subscriptions", params: sub_params.to_json, headers: { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }

        expect(response).to be_successful
        subscription = JSON.parse(response.body, symbolize_names: true)
        expect(subscription[:data][:attributes][:customer_id]).to eq(@customer.id)
        expect(subscription[:data][:attributes][:tea_id]).to eq(@tea.id)
        expect(subscription[:data][:attributes][:price]).to eq(1.5)
        expect(subscription[:data][:attributes][:status]).to eq("active")
        expect(subscription[:data][:attributes][:frequency]).to eq("weekly")
      end

      it 'defaults status and frequency if not provided' do
        post "/api/v1/customers/#{@customer.id}/subscriptions", params: { customer_id: @customer.id, tea_id: @tea.id, price: 1.5 }.to_json, headers: { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }
        subscription = JSON.parse(response.body, symbolize_names: true)
        expect(subscription[:data][:attributes][:status]).to eq("active")
        expect(subscription[:data][:attributes][:frequency]).to eq("weekly")
      end
    end

    describe "sad path" do
      it 'returns an error if customer_id is missing' do
        post "/api/v1/customers/9999/subscriptions", params: {tea_id: @tea.id, price: 1.5, frequency: "weekly" }.to_json, headers: { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }
        
        error = JSON.parse(response.body, symbolize_names: true)
        expect(error[:errors][0][:status]).to eq(404)
        expect(error[:errors][0][:title]).to eq("Couldn't find Customer with 'id'=9999")
      end

      it 'returns an error if tea_id is missing' do
        post "/api/v1/customers/#{@customer.id}/subscriptions", params: { customer_id: @customer.id, price: 1.5, frequency: "weekly" }.to_json, headers: { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }
        error = JSON.parse(response.body, symbolize_names: true)
        expect(error[:errors][0][:status]).to eq(404)
        expect(error[:errors][0][:title]).to eq("Validation failed: Tea must exist")
      end

      it 'returns an error if price is missing' do
        post "/api/v1/customers/#{@customer.id}/subscriptions", params: { customer_id: @customer.id, tea_id: @tea.id, frequency: "weekly" }.to_json, headers: { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }
        error = JSON.parse(response.body, symbolize_names: true)
        expect(error[:errors][0][:status]).to eq(404)
        expect(error[:errors][0][:title]).to eq("Validation failed: Price can't be blank")
      end
    end
  end

  describe "update a subscription" do
    describe "happy path" do
      it "can update a subscription's status" do
        patch "/api/v1/customers/#{@customer.id}/subscriptions/#{@subscription.id}", params: { status: "cancelled"}.to_json, headers: { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }

        subscription = JSON.parse(response.body, symbolize_names: true)
        expect(subscription[:data][:attributes][:status]).to eq("cancelled")
      end

      it 'can update a subscriptions frequnecy' do
        expect(@subscription[:frequency]).to eq("biweekly")
        patch "/api/v1/customers/#{@customer.id}/subscriptions/#{@subscription.id}", params: { frequency: "monthly"}.to_json, headers: { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }

        subscription = JSON.parse(response.body, symbolize_names: true)
        expect(subscription[:data][:attributes][:frequency]).to eq("monthly")
      end
    end

    describe "sad path" do
      it 'returns an error if subscription does not exist' do
        patch "/api/v1/customers/#{@customer.id}/subscriptions/100000", params: { status: "cancelled"}.to_json, headers: { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }
        
        expect(response.status).to eq(404)
        error = JSON.parse(response.body, symbolize_names: true)
        expect(error[:errors][0][:status]).to eq(404)
        expect(error[:errors][0][:title]).to eq("Couldn't find Subscription with 'id'=100000")
      end
    end
  end

  describe "get all subscriptions" do
    describe "happy path" do
      it 'can get all of a users subscriptions' do
        get "/api/v1/customers/#{@customer[:id]}/subscriptions"
        
        expect(response).to be_successful
        subscriptions = JSON.parse(response.body, symbolize_names: true)
        expect(subscriptions[:data].count).to eq(1)

        sub_params = { customer_id: @customer.id, tea_id: @tea.id, price: 1.5, status: "active", frequency: "weekly" }
        post "/api/v1/customers/#{@customer.id}/subscriptions", params: sub_params.to_json, headers: { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }

        get "/api/v1/customers/#{@customer[:id]}/subscriptions"

        subscriptions = JSON.parse(response.body, symbolize_names: true)
        expect(response).to be_successful
        expect(subscriptions[:data].count).to eq(2)
      end
    end
  end
end