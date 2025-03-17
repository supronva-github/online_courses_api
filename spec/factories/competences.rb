FactoryBot.define do
  factory :competence do
    sequence(:name) { |n| "Mytext#{n}" }
  end
end
