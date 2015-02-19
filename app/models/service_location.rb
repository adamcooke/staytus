# == Schema Information
#
# Table name: service_locations
#
#  id          :integer          not null, primary key
#  service_id  :integer
#  location_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class ServiceLocation < ActiveRecord::Base

  belongs_to :service
  belongs_to :location

end
