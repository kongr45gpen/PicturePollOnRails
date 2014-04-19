FactoryGirl.define do
  factory :user do
    username "factorytester"
    email "factory@tester.com"
    password "test123456"
    password_confirmation "test123456"
  end
end
