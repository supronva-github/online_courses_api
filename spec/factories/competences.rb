# frozen_string_literal: true

FactoryBot.define do
  factory :competence do
    sequence(:name) { |n| "Mytext#{n}" }
  end
end
