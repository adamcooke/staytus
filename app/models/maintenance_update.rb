# == Schema Information
#
# Table name: maintenance_updates
#
#  id             :integer          not null, primary key
#  maintenance_id :integer
#  user_id        :integer
#  text           :text(65535)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class MaintenanceUpdate < ActiveRecord::Base

  belongs_to :maintenance
  belongs_to :user

  validates :text, :presence => true

  scope :ordered, -> { order(:id => :desc) }

end
