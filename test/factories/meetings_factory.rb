FactoryBot.define do
  factory :meeting do
    phase
    sequence(:name) { |n| "Meeting #{n}" }
  end
end
