FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "person#{n}@example.com" }
    password 'resistiremos'
    password_confirmation { |u| u.password }
  end
end
