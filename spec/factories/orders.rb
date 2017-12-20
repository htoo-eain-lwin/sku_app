FactoryBot.define do
  factory :order do
    inventory
    total 4
    shipping_status "reserved"
  end
end
