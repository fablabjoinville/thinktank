class Chapter < ApplicationRecord
  has_many :clusters, dependent: :nullify

  validates :title, presence: true
  validates :edition_year, presence: true, inclusion: { in: 2023..2030 }

  scope :ordered_by_year, -> { order(edition_year: :desc) }
  scope :year_and_title_options, -> { ordered_by_year.map { |c| [c.to_s, c.id] } }

  def self.ransackable_associations(auth_object = nil)
    ['clusters']
  end

  def self.ransackable_attributes(auth_object = nil)
    ['edition_year', 'id', 'title']
  end

  def self.latest_year
    ordered_by_year.first.edition_year
  end

  def to_s
    "#{edition_year} - #{title}"
  end
end
