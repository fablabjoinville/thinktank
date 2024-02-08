Faker::Config.locale = 'pt-BR'

puts "Creating Admins..."

User.create_with(
  full_name: "Admin Marvin",
  password: "password",
  password_confirmation: "password",
  authorization_level: :super_admin,
  birthday: Faker::Date.birthday,
  nickname: Faker::Artist.name,
  cpf: CPF.generate(true),
  rg: Faker::IDNumber.brazilian_id(formatted: true),
  phone_number: "(47) 3034-5432",
  celular_number: Faker::PhoneNumber.cell_phone,
  address: Faker::Address.full_address,
  gender: Person.genders.values.sample,
).find_or_create_by!(email: "admin@example.com")

puts "Creating Facilitators..."

User.create_with(
  full_name: "Facilitador",
  password: "password",
  password_confirmation: "password",
  authorization_level: :facilitator,
  birthday: Faker::Date.birthday,
  nickname: Faker::Artist.name,
  cpf: CPF.generate(true),
  rg: Faker::IDNumber.brazilian_id(formatted: true),
  phone_number: "(47) 3043-1234",
  celular_number: Faker::PhoneNumber.cell_phone,
  address: Faker::Address.full_address,
  gender: Person.genders.values.sample,
).find_or_create_by!(email: "facilitator@example.com")
