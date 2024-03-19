class Team < ApplicationRecord
  belongs_to :axis
  belongs_to :cluster

  has_and_belongs_to_many :clusters

  has_many :events, dependent: :destroy
  has_many :members, dependent: :destroy
  has_many :people, through: :members

  validates :name, presence: true, uniqueness: true
  validates :link_teams, format: { with: /\A(https?:\/\/)?(?:www\.)?teams\.microsoft\.com\/.+\z/i,
    message: "deve ser um link no formato teams.microsoft.com/XXXXXX" }, allow_blank: true
  validates :link_miro, format: { with: /\A(https?:\/\/)?(?:www\.)?miro\.com\/.+\z/i,
    message: "deve ser um link no formato miro.com/XXXXXX" }, allow_blank: true

  before_save :before_save_format_links_callback

  scope :ordered_by_name, -> { order('LOWER(name) ASC') }

  ransacker :name, type: :string, formatter: proc { |v| I18n.transliterate(v) } do |_|
    Arel.sql("unaccent(\"name\")")
  end

  def self.ransackable_associations(auth_object = nil)
    ['axis']
  end

  def self.ransackable_attributes(auth_object = nil)
    ['id', 'cluster_id', 'name']
  end

  def to_s
    "Equipe #{name}"
  end

  def modality
    return "Não definida" if members.empty?
    modalities = members.map(&:modality).uniq
    modality = modalities.size > 1 ? 'hibrido' : modalities.first
    Member.humanized_enum_value(:modality, modality)
  end

  private

  def before_save_format_links_callback
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
