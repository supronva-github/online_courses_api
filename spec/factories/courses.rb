FactoryBot.define do
  factory :course do
    sequence(:title) { |n| "Mytext#{n}" }
    description { "" }
    association :author, factory: :user
  end
end
