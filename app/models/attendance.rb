class Attendance < ApplicationRecord
  belongs_to :member
  belongs_to :event
  has_one :team, through: :event

  validates :member, presence: true
  validates :event, presence: true
  validates :status, presence: true
  validates :reason, presence: true, if: ->{ absent? }

  validates_uniqueness_of :member_id, scope: :event_id, message: "Presença já registrada para esse membro nesse encontro"

  enum status: [:not_registered, :present, :absent]

  delegate :avatar_path, :full_name, :email, :celular_number, :phone_number, to: :member
end
