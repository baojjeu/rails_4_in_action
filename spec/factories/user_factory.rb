FactoryGirl.define do
  factory :user do
    name 'Baozi'
    email 'sample@example.com'
    password 'password'
    password_confirmation 'password'
  end
end