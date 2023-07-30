# == Schema Information
#
# Table name: events
#
#  id         :bigint           not null, primary key
#  date       :date             not null
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  meeting_id :bigint           not null
#  team_id    :bigint           not null
#
# Indexes
#
#  index_events_on_meeting_id  (meeting_id)
#  index_events_on_team_id     (team_id)
#
# Foreign Keys
#
#  fk_rails_...  (meeting_id => meetings.id)
#  fk_rails_...  (team_id => teams.id)
#
class Event < ApplicationRecord
  belongs_to :meeting
  belongs_to :team

  validates :name, presence: true
  validates :date, presence: true

  ransacker :name, type: :string, formatter: proc { |v| I18n.transliterate(v) } do |_|
    Arel.sql("unaccent(\"name\")")
  end
end
