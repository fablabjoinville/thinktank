# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

return unless Rails.env.development? || Rails.env.staging?

Faker::Config.locale = 'pt-BR'

puts "Cleaning entities..."

Company.destroy_all
User.destroy_all
Person.destroy_all
Phase.destroy_all
Axis.destroy_all
Team.destroy_all
Meeting.destroy_all
Cluster.destroy_all

load(File.join(Rails.root, 'db/seeds/admins.rb'))

#########################################################################################################

puts "Creating Tools..."

(0..5).each do |n|
  Tool.create!(name: Faker::App.unique.name)
end

#########################################################################################################

puts "Creating Companies..."

(0..2).each do |n|
  Company.create!(name: Faker::Company.unique.name, cnpj: CNPJ.generate(true))
end

#########################################################################################################

puts "Creating Person..."

(0..10).each do |n|
  person = Person.create!({
    full_name: Faker::Name.unique.name,
    birthday: Faker::Date.birthday,
    nickname: Faker::Artist.name,
    cpf: CPF.generate(true),
    rg: Faker::IDNumber.brazilian_id(formatted: true),
    phone_number: "(47) 3034-5432",
    celular_number: Faker::PhoneNumber.cell_phone,
    address: Faker::Address.full_address,
    gender: Person.genders.values.sample,
    company: Company.order("RANDOM()").first,
    email: Faker::Internet.unique.email
  })
  person.image.attach(io: File.open(Rails.root.join("db/seeds/thinktank.jpeg")), filename: 'thinktank.jpeg')
end

#########################################################################################################

phase_one = Phase.create!(name: "Fase 1")
phase_one.tools << Tool.first
phase_one.tools << Tool.second
phase_one.tools << Tool.third
phase_one.save!

phase_two = Phase.create!(name: "Fase 2")
phase_two.tools << Tool.fourth
phase_two.tools << Tool.fifth
phase_two.save!

Meeting.create!(name: "Encontro 1 F1", phase: Phase.first)
Meeting.create!(name: "Encontro 2 F1", phase: Phase.first)
Meeting.create!(name: "Encontro 1 F2", phase: Phase.second)
Meeting.create!(name: "Encontro 2 F2", phase: Phase.second)

#########################################################################################################

Axis.create!(
  title: "Eixo orientador equipe 1",
  description: "Descrição do eixo orientador de trabalho para as equipes."
)

Team.create!(
  name: "Equipe 1",
  link_miro: "https://miro.com/#{SecureRandom.hex}",
  link_teams: "https://teams.microsoft.com/#{SecureRandom.hex}",
  axis: Axis.first
)

Member.create!(team: Team.first, person: Person.first, role: :mm)
Member.create!(team: Team.first, person: Person.second, role: :sol)
Member.create!(team: Team.first, person: Person.third, role: :sol)

#########################################################################################################

Axis.create!(
  title: "Eixo orientador equipe 2",
  description: "Descrição do eixo orientador de trabalho para as equipes."
)

Team.create!(
  name: "Equipe 2",
  link_miro: "https://miro.com/#{SecureRandom.hex}",
  link_teams: "https://teams.microsoft.com/#{SecureRandom.hex}",
  axis: Axis.second
)

Member.create!(team: Team.second, person: Person.fourth, role: :mm)
Member.create!(team: Team.second, person: Person.fifth, role: :sol)
Member.create!(team: Team.second, person: Person.find(5), role: :sol)

# Meeting.create!(
#   team: Team.second,
#   title: "Encontro 1 da equipe 2",
#   date: Faker::Date.in_date_period(month: 2),
#   phase: Phase.first
# )

# Meeting.create!(
#   team: Team.second,
#   title: "Encontro 2 da equipe 2",
#   date: Faker::Date.in_date_period(month: 2),
#   phase: Phase.first
# )

#########################################################################################################

Axis.create!(
  title: "Eixo orientador equipe 3",
  description: "Descrição do eixo orientador de trabalho para as equipes."
)

Team.create!(
  name: "Equipe 3",
  link_miro: "https://miro.com/#{SecureRandom.hex}",
  link_teams: "https://teams.microsoft.com/#{SecureRandom.hex}",
  axis: Axis.third
)

Member.create!(team: Team.second, person: Person.find(6), role: :mm)
Member.create!(team: Team.second, person: Person.find(7), role: :sol)
Member.create!(team: Team.second, person: Person.find(8), role: :sol)

# Meeting.create!(
#   team: Team.third,
#   title: "Encontro 1 da equipe 3",
#   date: Faker::Date.in_date_period(month: 2)
# )

#########################################################################################################

chapter_one = Chapter.create!(title: "Causa Engajadora Capítulo 1")
chapter_two = Chapter.create!(title: "Causa Engajadora Capítulo 2")

facilitator = User.create_with(
  full_name: "Facilitator Trillian",
  company: Company.first,
  password: "password",
  password_confirmation: "password",
  authorization_level: :facilitator,
  birthday: Faker::Date.birthday,
  nickname: Faker::Artist.name,
  cpf: CPF.generate(true),
  rg: Faker::IDNumber.brazilian_id(formatted: true),
  phone_number: "(47) 3034-5432",
  celular_number: Faker::PhoneNumber.cell_phone,
  address: Faker::Address.full_address,
  gender: Person.genders.values.sample,
).find_or_create_by!(email: "facilitator@example.com")

cluster_one = Cluster.create!(
  chapter: chapter_one,
  user: facilitator,
  address: Faker::Address.full_address,
  start_time: Time.new(2000, 1, 1, 9, 0, 0),
  end_time: Time.new(2000, 1, 1, 17, 0, 0),
  week_day: 2,
  modality: 1,
  link: "https://link_meet_cluster_one.com"
)
cluster_one.teams << Team.first
cluster_one.teams << Team.second
cluster_one.save!

cluster_two = Cluster.create!(
  chapter: chapter_two,
  user: facilitator,
  address: Faker::Address.full_address,
  start_time: Time.new(2000, 1, 1, 9, 0, 0),
  end_time: Time.new(2000, 1, 1, 17, 0, 0),
  week_day: 2,
  modality: 0,
  link: "https://link_meet_cluster_two.com"
)
cluster_two.teams << Team.third
cluster_two.save!
