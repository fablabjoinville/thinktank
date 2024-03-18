FactoryBot.define do
  factory :cluster do
    address { Faker::Address.full_address }
    chapter
    end_time { Time.now.change(hour: 17, min: 0, sec: 0) }
    sequence(:link) { |n| "https://link_meet_cluster#{n}.com" }
    start_time { Time.now.change(hour: 9, min: 0, sec: 0) }
    user
    week_day { 2 }
  end
end
