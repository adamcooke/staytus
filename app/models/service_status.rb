# == Schema Information
#
# Table name: service_statuses
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  permalink   :string(255)
#  color       :string(255)
#  status_type :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class ServiceStatus < ActiveRecord::Base

  STATUS_TYPES = ['ok', 'minor', 'major', 'maintenance']

  validates :name, :presence => true
  validates :permalink, :presence => true, :uniqueness => true
  validates :status_type, :inclusion => {:in => STATUS_TYPES}

  default_value :permalink, -> { self.name.parameterize }

  def self.create_defaults
    ServiceStatus.create!(:name => 'Operational', :status_type => 'ok', :color => '2FCC66')
    ServiceStatus.create!(:name => 'Degraded Performance', :status_type => 'minor', :color => 'F1C40F')
    ServiceStatus.create!(:name => 'Partial Outage', :status_type => 'minor', :color => 'E67E22')
    ServiceStatus.create!(:name => 'Major Outage', :status_type => 'major', :color => 'E74C3C')
    ServiceStatus.create!(:name => 'Maintenance', :status_type => 'maintenance', :color => 'AAAAAA')
  end

end
