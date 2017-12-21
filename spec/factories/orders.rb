FactoryBot.define do

  factory :order do
    inventory
    total 4
    shipping_status "reserved"
    customer
    sales_person
  end
end
