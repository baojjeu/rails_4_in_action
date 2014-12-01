FactoryGirl.define do
  factory :user do
    name 'Baozi'
    email 'baozi.rails@gmail.com'
    password 'password'
    password_confirmation 'password'
  end
end