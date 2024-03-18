FactoryBot.define do
  factory :axis do
    description { "Axis description" }
    sequence(:title) { |n| "Axis #{n}" }
  end
end
