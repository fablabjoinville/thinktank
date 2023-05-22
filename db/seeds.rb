# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

return unless Rails.env.development? || Rails.env.staging?

puts "Cleaning entities..."
Attendance.destroy_all
Event.destroy_all
Member.destroy_all
Team.destroy_all
User.destroy_all
Tool.destroy_all
Axis.destroy_all

puts "Creating entities..."

Tool.create!(name: "Ferramenta 1")
Tool.create!(name: "Ferramenta 2")
Tool.create!(name: "Ferramenta 3")
Tool.create!(name: "Ferramenta 4")
Tool.create!(name: "Ferramenta 5")

admin = User.create_with(
  full_name: "Admin Marvin",
  password: "password",
  password_confirmation: "password",
  authorization_level: :super_admin,
  birthday: Date.new(1982,1,1),
  nickname: "admin",
  cpf: CPF.generate(true),
  rg: "12345678",
  phone_number: "(47) 3037-7751",
  celular_number: "(47) 99255-2439",
  address: "Rua Test, 99, Joinville/SC",
  gender: :other
).find_or_create_by!(email: "admin@example.com")

facilitator = User.create_with(
  full_name: "Facilitator Trillian",
  password: "password",
  password_confirmation: "password",
  authorization_level: :facilitator,
  birthday: Date.new(1982,1,1),
  nickname: "facilitator",
  cpf: CPF.generate(true),
  rg: "23456781",
  phone_number: "(47) 3037-7751",
  celular_number: "(47) 99255-2439",
  address: "Rua Test, 100, Joinville/SC",
  gender: :man
).find_or_create_by!(email: "facilitator@example.com")

#########################################################################################################

axis_one = Axis.create!(
  title: "Eixo orientador equipe 1",
  description: "Descrição do eixo orientador de trabalho para as equipes."
)

team_one = Team.create!(
  name: "Equipe 1",
  link_miro: "https://miro.com/#{SecureRandom.hex}",
  link_teams: "https://teams.microsoft.com/#{SecureRandom.hex}",
  axis: axis_one
)

member_one_team_one = Member.create_with(
  full_name: "Membro um da equipe um",
  role: :mm,
  birthday: Date.new(1982,1,1),
  nickname: "membro um da equipe um",
  cpf: CPF.generate(true),
  rg: "23312782",
  phone_number: "(47) 3033-7732",
  celular_number: "(47) 99244-2439",
  address: "Rua Test, 100, Joinville/SC",
  active: true,
  gender: :woman,
  team: team_one
).find_or_create_by!(email: "member_one_team_one@example.com")

member_two_team_one = Member.create_with(
  full_name: "Membro dois da equipe um",
  role: :mm,
  birthday: Date.new(1982,1,1),
  nickname: "membro dois da equipe um",
  cpf: CPF.generate(true),
  rg: "23456542",
  phone_number: "(47) 3033-7333",
  celular_number: "(47) 99244-4449",
  address: "Rua Test, 100, Joinville/SC",
  active: true,
  gender: :woman,
  team: team_one
).find_or_create_by!(email: "member_two_team_one@example.com")

member_three_team_one = Member.create_with(
  full_name: "Membro tres da equipe um",
  role: :mm,
  birthday: Date.new(1982,1,1),
  nickname: "membro tres da equipe um",
  cpf: CPF.generate(true),
  rg: "23445235",
  phone_number: "(47) 3043-5533",
  celular_number: "(47) 99654-4449",
  address: "Rua Test, 100, Joinville/SC",
  active: true,
  gender: :woman,
  team: team_one
).find_or_create_by!(email: "member_three_team_one@example.com")

event_one_team_one = Event.create!(
  team: team_one,
  title: "Evento 1 da equipe 1",
  date: Date.today - 3.days,
  ref: :p,
  item_a_assessment: 3,
  item_a_comment: "Bom esforço",
  item_b_assessment: 4,
  item_b_comment: "Excelente trabalho",
  item_c_assessment: 2,
  item_c_comment: "Precisa melhorar",
  item_d_assessment: 5,
  item_d_comment: "Excepcional",
  general_comments: "No geral, bom progresso"
)

evento_dois_team_one = Event.create!(
  team: team_one,
  title: "Evento 2 da equipe 1",
  date: Date.today + 20.days,
  ref: :p
)

#########################################################################################################

axis_two = Axis.create!(
  title: "Eixo orientador equipe 2",
  description: "Descrição do eixo orientador de trabalho para as equipes."
)

team_two = Team.create!(
  name: "Equipe 2",
  link_miro: "https://miro.com/#{SecureRandom.hex}",
  link_teams: "https://teams.microsoft.com/#{SecureRandom.hex}",
  axis: axis_two
)

member_one_team_two = Member.create_with(
  full_name: "Membro um da equipe dois",
  role: :mm,
  birthday: Date.new(1982,1,1),
  nickname: "membro um da equipe dois",
  cpf: CPF.generate(true),
  rg: "23421781",
  phone_number: "(47) 3035-7751",
  celular_number: "(47) 98255-2439",
  address: "Rua Test, 100, Joinville/SC",
  active: true,
  gender: :woman,
  team: team_two
).find_or_create_by!(email: "member_one_team_two@example.com")

member_two_team_two = Member.create_with(
  full_name: "Membro dois da equipe dois",
  role: :mm,
  birthday: Date.new(1982,1,1),
  nickname: "membro dois da equipe dois",
  cpf: CPF.generate(true),
  rg: "23453281",
  phone_number: "(47) 3034-7751",
  celular_number: "(47) 99555-2439",
  address: "Rua Test, 100, Joinville/SC",
  active: true,
  gender: :woman,
  team: team_two
).find_or_create_by!(email: "member_two_team_two@example.com")

member_three_team_two = Member.create_with(
  full_name: "Membro tres da equipe dois",
  role: :mm,
  birthday: Date.new(1982,1,1),
  nickname: "membro tres da equipe dois",
  cpf: CPF.generate(true),
  rg: "23446381",
  phone_number: "(47) 3037-7721",
  celular_number: "(47) 99255-4439",
  address: "Rua Test, 100, Joinville/SC",
  active: true,
  gender: :woman,
  team: team_two
).find_or_create_by!(email: "member_three_team_two@example.com")

event_one_team_two = Event.create!(
  team: team_two,
  title: "Evento 1 da equipe 2",
  date: Date.today - 3.days,
  ref: :e,
  item_a_assessment: 4,
  item_a_comment: "Bom trabalho",
  item_b_assessment: 5,
  item_b_comment: "Ótimo trabalho",
  item_c_assessment: 3,
  item_c_comment: "Satisfatório",
  item_d_assessment: 4,
  item_d_comment: "Bom trabalho",
  general_comments: "Continue com o bom trabalho"
)

evento_dois_team_two = Event.create!(
  team: team_two,
  title: "Evento 2 da equipe 2",
  date: Date.today - 40.days,
  ref: :e,
  item_a_assessment: 4,
  item_a_comment: "Bom trabalho",
  item_b_assessment: 5,
  item_b_comment: "Ótimo trabalho",
  item_c_assessment: 3,
  item_c_comment: "Satisfatório",
  item_d_assessment: 4,
  item_d_comment: "Bom trabalho",
  general_comments: "Continue com o bom trabalho"
)

#########################################################################################################

axis_three = Axis.create!(
  title: "Eixo orientador equipe 3",
  description: "Descrição do eixo orientador de trabalho para as equipes."
)

team_three = Team.create!(
  name: "Equipe 3",
  link_miro: "https://miro.com/#{SecureRandom.hex}",
  link_teams: "https://teams.microsoft.com/#{SecureRandom.hex}",
  axis: axis_three
)

member_one_team_three = Member.create_with(
  full_name: "Membro Três",
  role: :mm,
  birthday: Date.new(1982,1,1),
  nickname: "membro tres",
  cpf: CPF.generate(true),
  rg: "23456783",
  phone_number: "(47) 3037-7751",
  celular_number: "(47) 99255-2439",
  address: "Rua Test, 100, Joinville/SC",
  active: true,
  gender: :woman,
  team: team_three
).find_or_create_by!(email: "member_three@example.com")

event_one_team_three = Event.create!(
  team: team_three,
  title: "Evento 1 da equipe 3",
  date: Date.today - 2,
  ref: :p,
  item_a_assessment: 2,
  item_a_comment: "Pode melhorar",
  item_b_assessment: 1,
  item_b_comment: "Precisa de muita melhoria",
  item_c_assessment: 3,
  item_c_comment: "Apenas ok",
  item_d_assessment: 2,
  item_d_comment: "Poderia melhorar",
  general_comments: "Precisa focar em áreas de melhoria"
)

#########################################################################################################

cluster_one = Cluster.create!(
  user: facilitator,
  address: "Endereço do cluster um",
  start_time: Time.new(2000, 1, 1, 9, 0, 0),
  end_time: Time.new(2000, 1, 1, 17, 0, 0),
  week_day: 2,
  modality: 1,
  link: "https://link_meet_cluster_one.com"
)
cluster_one.teams << team_one
cluster_one.teams << team_two
cluster_one.save!

cluster_two = Cluster.create!(
  user: facilitator,
  address: "Endereço do cluster dois",
  start_time: Time.new(2000, 1, 1, 9, 0, 0),
  end_time: Time.new(2000, 1, 1, 17, 0, 0),
  week_day: 2,
  modality: 0,
  link: "https://link_meet_cluster_two.com"
)
cluster_two.teams << team_three
cluster_two.save!
