require 'csv'

namespace :data do
  task companies: :environment do
    filepath = File.read(Rails.root.join('lib/tasks/data/companies.csv'))
    failed = []
    exists = []

    csv = CSV.parse(filepath, headers: true)
    csv.each do |row|
      row_hash = row.to_hash
      puts "IMPORTING ROW: #{row_hash}"

      company = Company.where(cnpj: row_hash['company.cnpj']).first_or_initialize
      if company.new_record?
        begin
          company.cnpj = row_hash['company.cnpj']
          company.name = row_hash['company.name']
          company.save!

          puts "### COMPANY: CREATED"
        rescue StandardError => e
          puts "### COMPANY: ERROR #{e}"
          failed << [row_hash['company.name'], row_hash['company.cnpj']]
        end
      else
        puts "### COMPANY: ALREADY EXISTS"
        exists << [row_hash['company.name'], row_hash['company.cnpj']]
      end
    end

    puts("failed", failed)
    puts("exists", exists)
  end

  task members: :environment do
    filepath = File.read(Rails.root.join('lib/tasks/data/members.csv'))

    csv = CSV.parse(filepath, headers: true)
    csv.each do |row|
      row_hash = row.to_hash
      puts "IMPORTING ROW: #{row_hash}"

      team = Team.find(row_hash['team_id'])
      unless team.present?
        puts "### TEAM: ERROR does't exist"
        next
      end

      person = Person.find(row_hash['person_id'])
      unless person.present?
        puts "### PERSON: ERROR doesn't exist"
        next
      end

      active = row_hash['active'].casecmp?('TRUE')
      role = row_hash['role'].downcase

      member = Member.new(
        active: active,
        team: team,
        person: person,
        role: role
      )

      if member.save
        puts "### MEMBER: CREATED"
      else
        puts "### MEMBER: ERROR #{member.errors.full_messages}"
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
      # company = create_or_initialize_company!(row_hash)

      team = Team.where(
        name: row_hash['team.name'],
        created_at: Time.zone.now.beginning_of_year..Time.zone.now.end_of_year
      ).first

      puts "### TEAM: #{team.name}"

      next unless team.present?

      create_or_initialize_member!(row_hash, person, team)
    end
  end
end

def create_or_initialize_person!(row_hash)
  return if row_hash['person.full_name'].blank?

  person = Person.where(full_name: row_hash['person.full_name']).first_or_initialize

  if person.new_record?
    begin
      person.full_name = row_hash['person.full_name']
      person.celular_number = row_hash['person.celular_number'] if row_hash['person.celular_number'].present?
      person.email = row_hash['person.email'] || "#{row_hash['person.nickname']}@projetoresgate.org.br"
      person.nickname = row_hash['person.nickname'] if row_hash['person.nickname'].present?
      person.cpf = row_hash['person.cpf'] if row_hash['person.cpf'].present?
      person.rg = row_hash['person.rg'] if row_hash['person.rg'].present?
      person.birthday = row_hash['person.birthday'] if row_hash['person.birthday'].present?
      person.gender = row_hash['person.gender'] if row_hash['person.gender'].present?
      person.address = row_hash['person.address'] if row_hash['person.address'].present?

      person.save!

      puts "### PERSON: CREATED"
    rescue StandardError => e
      puts "### PERSON: ERROR #{e}"
    end
  else
    puts "### PERSON: ALREADY EXISTS"
  end

  person
end

def create_or_initialize_company!(row_hash)
  return if row_hash['company.cnpj'].blank? && row_hash['company.name'].blank?

  company = Company.where(cnpj: row_hash['company.cnpj']).first_or_initialize
  if company.new_record?
    begin
      company.cnpj = row_hash['company.cnpj']
      company.name = row_hash['company.name']

      company.save!

      puts "### COMPANY: CREATED"
    rescue StandardError => e
      puts "### COMPANY: #{e}"
    end
  else
    puts "### COMPANY: ALREADY EXISTS"
  end

  company
end

def create_or_initialize_member!(row_hash, person, team)
  member = Member.where(person: person, team: team).first_or_initialize

  if member.new_record?
    begin
      member.role = row_hash['member.role'] if row_hash['member.role'].present?
      member.modality = row_hash['member.modality'] if row_hash['member.modality'].present?
      member.active = true
      member.save!

      puts "### MEMBER: CREATED"
    rescue StandardError => e
      puts "### MEMBER: ERROR #{e}"
    end
  else
    puts "### MEMBER: ALREADY EXISTS"
  end

  member
rescue StandardError => e
  puts "### MEMBER: ERROR #{e}"
end
