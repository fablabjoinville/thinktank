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
end
