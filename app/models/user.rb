class User < Person
  devise :database_authenticatable,
         :recoverable, :rememberable, :validatable

  has_many :clusters, foreign_key: :person_id

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
