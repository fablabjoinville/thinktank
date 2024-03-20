FactoryBot.define do
  factory :user do
    address { Faker::Address.full_address }
    birthday { Faker::Date.birthday }
    celular_number { "(47) 99144-3325" }
    company
    cpf { CPF.generate(true) }
    full_name { Faker::Name.unique.name }
    gender { User.genders.values.sample }
    image { File.open(Rails.root.join("db/seeds/thinktank.jpeg")) }
    nickname { "nickname" }
    phone_number { "(47) 3034-5432" }
    rg { Faker::IDNumber.brazilian_id(formatted: true) }
    sequence(:email) { |n| "user#{n}@example.com" }

    authorization_level { :facilitator }
    password { "password" }
    password_confirmation { "password" }
  end
end
