namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    User.create!(username: "exampleuser",
                 email: "user@example.com",
                 password: "testpassword",
                 password_confirmation: "testpassword")
    99.times do |n|
      username = Faker::Internet.user_name
      email = Faker::Internet.safe_email(username)
      User.create(username: username,
                   email: email,
                   password: username,
                   password_confirmation: username)
    end
  end
end
