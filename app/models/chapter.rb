class Chapter < ApplicationRecord
  has_many :clusters, dependent: :nullify

  validates :title, presence: true
  validates :edition_year, presence: true, inclusion: { in: 2023..2030 }
  validates :shared, inclusion: { in: [true, false] }

  def self.ransackable_associations(auth_object = nil)
    ['clusters']
  end

  def self.ransackable_attributes(auth_object = nil)
    ['edition_year', 'id', 'shared', 'title']
  end
end
