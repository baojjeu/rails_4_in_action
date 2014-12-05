FactoryGirl.define do
  # everytime I call it, the n gets bigger.
  sequence(:email) { |n| "user#{n}@example.com" }

  factory :user do
    name 'Baozi'
    email { generate(:email) }
    password 'password'
    password_confirmation 'password'

    factory :admin_user do
      admin true
    end
  end
end