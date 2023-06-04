# == Schema Information
#
# Table name: people
#
#  id                     :bigint           not null, primary key
#  active                 :boolean          default(TRUE), not null
#  address                :string           default(""), not null
#  authorization_level    :integer          default("facilitator"), not null
#  birthday               :date
#  celular_number         :string           default(""), not null
#  cpf                    :string           default("")
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  full_name              :string           not null
#  gender                 :integer          default("other"), not null
#  nickname               :string           default(""), not null
#  phone_number           :string           default(""), not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  rg                     :string           default("")
#  role                   :integer          default(0), not null
#  type                   :string           not null
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  team_id                :bigint
#
# Indexes
#
#  index_people_on_cpf                   (cpf) UNIQUE WHERE (((cpf)::text <> ''::text) AND (cpf IS NOT NULL))
#  index_people_on_email                 (email) UNIQUE
#  index_people_on_reset_password_token  (reset_password_token) UNIQUE
#  index_people_on_rg                    (rg) UNIQUE WHERE (((rg)::text <> ''::text) AND (rg IS NOT NULL))
#  index_people_on_team_id               (team_id)
#
# Foreign Keys
#
#  fk_rails_...  (team_id => teams.id)
#
class User < Person
  devise :database_authenticatable,
         :recoverable, :rememberable, :validatable

  has_many :clusters, foreign_key: :person_id

  enum :authorization_level, [:super_admin, :admin, :facilitator], suffix: true, default: :facilitator

  attr_accessor :skip_password_validation

  def to_s
    "#{humanized_enum(:authorization_level)}: #{full_name}"
  end

  protected

  def password_required?
    return false if skip_password_validation
    super
  end
end
