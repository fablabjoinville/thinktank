# == Schema Information
#
# Table name: teams
#
#  id         :bigint           not null, primary key
#  link_miro  :string           default(""), not null
#  link_teams :string           default(""), not null
#  name       :string           default(""), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  axis_id    :bigint           not null
#
# Indexes
#
#  index_teams_on_axis_id  (axis_id)
#
# Foreign Keys
#
#  fk_rails_...  (axis_id => axes.id)
#
class Team < ApplicationRecord
  belongs_to :axis

  has_and_belongs_to_many :clusters

  has_many :members, dependent: :destroy
  has_many :people, through: :members
  has_many :meetings

  validates :name, presence: true, uniqueness: true
  validates :link_teams, format: { with: /\A(https?:\/\/)?(?:www\.)?teams\.microsoft\.com\/.+\z/i,
    message: "deve ser um link no formato teams.microsoft.com/XXXXXX" }, allow_blank: true
  validates :link_miro, format: { with: /\A(https?:\/\/)?(?:www\.)?miro\.com\/.+\z/i,
    message: "deve ser um link no formato miro.com/XXXXXX" }, allow_blank: true

  before_save :format_links

  def to_s
    "Equipe #{name} (#{members.count})"
  end

  private

  def format_links
    self.link_miro = format_link(self.link_miro)
    self.link_teams = format_link(self.link_teams)
  end

  def format_link(link)
    return "" if link.blank?
    uri = URI.parse(link)
    uri = URI.parse("http://#{link}") if uri.scheme.nil?
    uri.scheme = "https"
    uri.host = "www.#{uri.host}" unless uri.host.start_with?("www.")
    uri.to_s
  end
end
