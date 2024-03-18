FactoryBot.define do
  factory :team do
    axis
    cluster
    link_miro { "https://miro.com/#{SecureRandom.hex}" }
    link_teams { "https://teams.microsoft.com/#{SecureRandom.hex}" }
    sequence(:name) { |n| "Team #{n}" }
  end
end
