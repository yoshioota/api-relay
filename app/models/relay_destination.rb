# == Schema Information
#
# Table name: relay_destinations
#
#  id         :integer          not null, primary key
#  relay_id   :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  base_url   :string
#

class RelayDestination < ApplicationRecord
  belongs_to :relay
  validates :base_url, presence: true
end
