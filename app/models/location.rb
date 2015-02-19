# == Schema Information
#
# Table name: locations
#
#  id                    :integer          not null, primary key
#  name                  :string(255)
#  permalink             :string(255)
#  has_physical_presence :boolean          default("0")
#  physical_address      :string(255)
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#

class Location < ActiveRecord::Base

  validates :name, :presence => true
  validates :permalink, :presence => true, :uniqueness => true, :slug => true
  validates :physical_address, :presence => {:if => :has_physical_presence?}

  default_value :permalink, -> { self.name.parameterize }

  has_many :service_locations, :dependent => :destroy
  has_many :services, :through => :service_locations

  scope :ordered, -> { order(:name => :asc) }

end
