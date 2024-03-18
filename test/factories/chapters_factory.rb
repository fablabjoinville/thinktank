FactoryBot.define do
  factory :chapter do
    edition_year { Time.now.year }
    sequence(:title) { |n| "Chapter #{n}" }
  end
end
