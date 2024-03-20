FactoryBot.define do
  factory :member do
    user
    modality { Member.modality.sample }
    role { Member.roles.sample }
    team
  end
end
