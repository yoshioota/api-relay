# == Schema Information
#
# Table name: relays
#
#  id                          :integer          not null, primary key
#  title                       :string
#  max_logs_size               :integer
#  active_relay_destination_id :integer
#  created_at                  :datetime         not null
#  updated_at                  :datetime         not null
#

class Relay < ApplicationRecord
  belongs_to :active_relay_destination, class_name: RelayDestination.name, required: false
  has_many :relay_destinations, dependent: :destroy
  has_many :relay_logs, dependent: :destroy

  validates :title, presence: true
  validates :max_logs_size, numericality: { integer: true }, allow_nil: true

  def relay_point_path
    "/relays/#{id}/exec"
  end
end
