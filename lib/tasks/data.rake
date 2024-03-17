require 'csv'

namespace :data do
  task members: :environment do
    filepath = File.read(Rails.root.join('lib/tasks/data/members.csv'))

    csv = CSV.parse(filepath, headers: true)
    csv.each do |row|
      row_hash = row.to_hash
      puts "IMPORTING: #{row_hash}"

      team = Team.find(row_hash['team_id'])
      unless team.present?
        puts "ERROR [team doesn't exist]: #{row_hash}"
        next
      end

      person = Person.find(row_hash['person_id'])
      unless person.present?
        puts "ERROR [person doesn't exist]: #{row_hash}"
        next
      end

      active = row_hash['active'].casecmp?('TRUE')
      role = row_hash['role'].downcase

      member = Member.create(
        active: active,
        team: team,
        person: person,
        role: role
      )

      if member.save
        puts "SUCCESS [id: #{member.id}]: #{row_hash}"
      else
        puts "ERROR [#{member.errors.full_messages}]: #{row_hash}"
      end
    end
  end

  task people: :environment do
    filepath = File.read(Rails.root.join('lib/tasks/data/people.csv'))

    csv = CSV.parse(filepath, headers: true)
    csv.each do |row|
      row_hash = row.to_hash
      puts "IMPORTING ROW: #{row_hash}"

      person = create_or_initialize_person!(row_hash)
      company = create_or_initialize_company!(row_hash)

      team = Team.where(
        name: row_hash['team.name'],
        created_at: Time.zone.now.beginning_of_year..Time.zone.now.end_of_year
      ).first

      next unless team.present?

      create_or_initialize_member!(row_hash, person, team)
    end
  end
end

def create_or_initialize_person!(row_hash)
  return if row_hash['person.full_name'].blank?

  person = Person.where(full_name: row_hash['person.full_name']).first_or_initialize

  if person.new_record?
    puts "CREATING PERSON: #{row_hash['person.full_name']}"

    begin
      person.full_name = row_hash['person.full_name']
      person.celular_number = row_hash['person.celular_number']
      person.email = row_hash['person.email']
      person.nickname = row_hash['person.nickname']
      person.cpf = row_hash['person.cpf']
      person.rg = row_hash['person.rg']
      person.birthday = row_hash['person.birthday']
      person.gender = row_hash['person.gender']
      person.address = row_hash['person.address']

      person.save!

      puts "PERSON CREATED"

      person
    rescue e
      puts "ERROR CREATING PERSON: #{row_hash['person.full_name']} - #{e.message}"
    end
  else
    puts "PERSON ALREADY EXISTS: #{row_hash['person.full_name']}"
  end

  person
end

def create_or_initialize_company!(row_hash)
  return if row_hash['company.cnpj'].blank? && row_hash['company.name'].blank?

  company = Company.where(cnpj: row_hash['company.cnpj']).first_or_initialize
  if company.new_record?
    puts "CREATING COMPANY: #{row_hash['company.name']}"

    begin
      company.cnpj = row_hash['company.cnpj']
      company.name = row_hash['company.name']

      company.save!

      puts "COMPANY CREATED"

      company
    rescue StandardError => e
      puts "ERROR CREATING COMPANY: #{row_hash['company.name']} - #{e.message}"
    end
  else
    puts "COMPANY ALREADY EXISTS: #{row_hash['company.name']}"
  end

  company
end

def create_or_initialize_member!(row_hash, person, team)
  puts "CREATING MEMBER: #{person.full_name} - #{team.name} - #{row_hash['member.role']}"
  member = Member.where(person: person, team: team).first_or_initialize
  member.role = row_hash['member.role'] if row_hash['member.role'].present?
  member.modality = row_hash['member.modality'] if row_hash['member.modality'].present?
  member.active = true
  member.save!

  puts "MEMBER CREATED"

  member
rescue e
  puts "ERROR CREATING MEMBER: #{person.full_name} - #{team.name} - #{row_hash['member.role']} - #{e.message}"
end
