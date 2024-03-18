FactoryBot.define do
  factory :member do
    person
    modality { Member.modality.sample }
    role { Member.roles.sample }
    team
  end
end
