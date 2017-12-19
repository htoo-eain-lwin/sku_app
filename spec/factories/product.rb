FactoryBot.define do

  sequence :name do |n|
    "sku#{n}"
  end
  factory :product do
    name
    description "lorem ipsum"
    price 111
  end
end