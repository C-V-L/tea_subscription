FactoryBot.define do
  factory :customer do
    first_name { "John" }
    last_name { "Doe" }
    email { "johndoe@example.com" }
    address { "123 Main St" }
  end
end
