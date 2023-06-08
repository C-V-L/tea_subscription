class Api::V1::SubscriptionsController < ApplicationController
  wrap_parameters :subscription, include: [:customer_id, :tea_id, :price, :status, :frequency]
  def create
    begin
      render json: SubscriptionSerializer.new(Subscription.create!(subscription_params))
    end
  end

  def update
    begin
      render json: SubscriptionSerializer.new(Subscription.update(params[:id], subscription_params))
    end
  end

  def index
    begin
      render json: SubscriptionSerializer.new(Subscription.all)
    end
  end

  private

  def subscription_params
    params.require(:subscription).permit(:customer_id, :tea_id, :price, :status, :frequency)
  end
end