FactoryGirl.define do
  factory :user do
    sequence(:username)  { |n| "factoryuser_#{n}" }
    sequence(:email) { |n| "user_#{n}@factory.com" }
    password "test123456"
    password_confirmation "test123456"
  end
end
