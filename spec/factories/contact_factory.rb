FactoryGirl.define do
  factory :contact do
    sequence(:name) { |n| "testeador#{n}" }
    sequence(:email) { |n| "tester#{n}@testing.com" }
    body 'Yo soy testeador! testeador, testeador!!'
  end
end
