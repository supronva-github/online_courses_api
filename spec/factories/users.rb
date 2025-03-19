# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    email { Faker::Internet.email }
    password_digest { Faker::Internet.password(min_length: 12) }
    role { 'user' }
  end
end
