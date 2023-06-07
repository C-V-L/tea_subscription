FactoryBot.define do
  factory :tea do
    title { "Green Tea" }
    description { "Green tea is a type of tea that is made from Camellia sinensis leaves and buds that have not undergone the same withering and oxidation process used to make oolong teas and black teas." }
    temp { 180 }
    brew_time { 3 }
  end
end
