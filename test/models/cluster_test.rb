# == Schema Information
#
# Table name: clusters
#
#  id         :bigint           not null, primary key
#  address    :string
#  end_time   :time             not null
#  link       :text
#  modality   :integer          not null
#  start_time :time             not null
#  week_day   :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  person_id  :bigint           not null
#
# Indexes
#
#  index_clusters_on_person_id  (person_id)
#
# Foreign Keys
#
#  fk_rails_...  (person_id => people.id)
#
require "test_helper"

class ClusterTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
