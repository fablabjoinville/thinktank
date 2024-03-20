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

      user = User.find(row_hash['user_id'])
      unless user.present?
        puts "### USER: ERROR doesn't exist"
        next
      end

      active = row_hash['active'].casecmp?('TRUE')
      role = row_hash['role'].downcase

      member = Member.new(
        active: active,
        team: team,
        user: user,
        role: role
      )

      if member.save
        puts "### MEMBER: CREATED"
      else
        puts "### MEMBER: ERROR #{member.errors.full_messages}"
      end
    end
  end

  task users: :environment do
    filepath = File.read(Rails.root.join('lib/tasks/data/users.csv'))

    csv = CSV.parse(filepath, headers: true)
    csv.each do |row|
      row_hash = row.to_hash
      puts "IMPORTING ROW: #{row_hash}"

      user = create_or_initialize_user!(row_hash)
      # company = create_or_initialize_company!(row_hash)

      team = Team.where(
        name: row_hash['team.name'],
        created_at: Time.zone.now.beginning_of_year..Time.zone.now.end_of_year
      ).first

      puts "### TEAM: #{team.name}"

      next unless team.present?

      create_or_initialize_member!(row_hash, user, team)
    end
  end
end

def create_or_initialize_user!(row_hash)
  return if row_hash['user.full_name'].blank?

  user = User.where(full_name: row_hash['user.full_name']).first_or_initialize

  if user.new_record?
    begin
      user.full_name = row_hash['user.full_name']
      user.celular_number = row_hash['user.celular_number'] if row_hash['user.celular_number'].present?
      user.email = row_hash['user.email'] || "#{row_hash['user.nickname']}@projetoresgate.org.br"
      user.nickname = row_hash['user.nickname'] if row_hash['user.nickname'].present?
      user.cpf = row_hash['user.cpf'] if row_hash['user.cpf'].present?
      user.rg = row_hash['user.rg'] if row_hash['user.rg'].present?
      user.birthday = row_hash['user.birthday'] if row_hash['user.birthday'].present?
      user.gender = row_hash['user.gender'] if row_hash['user.gender'].present?
      user.address = row_hash['user.address'] if row_hash['user.address'].present?

      user.save!

      puts "### USER: CREATED"
    rescue StandardError => e
      puts "### USER: ERROR #{e}"
    end
  else
    puts "### USER: ALREADY EXISTS"
  end

  user
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

def create_or_initialize_member!(row_hash, user, team)
  member = Member.where(user: user, team: team).first_or_initialize

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
