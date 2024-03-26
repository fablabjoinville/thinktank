class Member < ApplicationRecord
  belongs_to :team
  has_one :cluster, through: :team
  has_one :chapter, through: :cluster

  belongs_to :user
  has_one :company, through: :user

  has_many :attendances, dependent: :destroy
  has_many :events, through: :attendances

  enum modality: [:presencial, :online, :hibrido]
  enum :role, [:mm, :mp, :sol], prefix: true, default: :sol

  delegate :avatar_path, :full_name, :email, :company, :celular_number, :phone_number, to: :user

  scope :filtered_by_latest_year, -> { joins(:chapter).where('chapters.edition_year = ?', Chapter.latest_year) }

  def self.ransackable_associations(auth_object = nil)
    ['company', 'user', 'team']
  end

  def self.ransackable_attributes(auth_object = nil)
    ['active', 'id', 'role']
  end

  def to_s
    company_name = company.present? ? "| #{company.name}" : ""
    "#{humanized_enum(:role)} | #{full_name}#{company_name}"
  end

  def attendances_counts
    total = events.count
    present = attendances.present.count
    absent = attendances.absent.count

    "#{total} eventos - #{present} presenças - #{absent} faltas"
  end
end
