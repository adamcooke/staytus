# == Schema Information
#
# Table name: maintenance_service_joins
#
#  id             :integer          not null, primary key
#  maintenance_id :integer
#  service_id     :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class MaintenanceServiceJoin < ActiveRecord::Base

  belongs_to :maintenance
  belongs_to :service

  validates :maintenance_id, :uniqueness => { :scope => :service_id }
  validates :maintenance_id, :service_id, presence: true

end
