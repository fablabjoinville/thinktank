class Assessment < ApplicationRecord
  belongs_to :assessmentable, polymorphic: true
  belongs_to :author, polymorphic: true
end
