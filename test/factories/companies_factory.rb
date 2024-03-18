FactoryBot.define do
  factory :company do
    name { Faker::Company.unique.name }
    cnpj { CNPJ.generate(true) }
  end
end
