# == Schema Information
#
# Table name: service_groups
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class ServiceGroup < ActiveRecord::Base

  validates :name, :presence => true
  scope :ordered, -> { order(:name => :asc) }

  has_many :services, :dependent => :nullify, :foreign_key => 'group_id'

end

