class SubscriptionSerializer
include JSONAPI::Serializer
  attributes :customer_id, :tea_id, :price, :status, :frequency
end