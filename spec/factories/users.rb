FactoryBot.define do

  sequence :email do |n|
    "example#{n}@example.com"
  end

  factory :user do
    email
    password "changeme"
    password_confirmation "changeme"
  end
end
