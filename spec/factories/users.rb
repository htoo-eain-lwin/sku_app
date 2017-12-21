FactoryBot.define do

  sequence :email do |n|
    "example#{n}@example.com"
  end

  factory :user do
    email
    password "changeme"
    password_confirmation "changeme"

    factory :customer do |f|
      f.after(:create) {|user| user.add_role(:customer)}
    end

    factory :sales_person do |f|
      f.after(:create) {|user| user.add_role(:sales)}
    end
  end
end
