FactoryBot.define do
  factory :subscription do
    customer_id { 1 }
    tea_id { 1 }
    price { 1.5 }
    status { 1 }
    frequency { 1 }
  end
end
