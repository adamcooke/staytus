# == Schema Information
#
# Table name: services
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  permalink  :string(255)
#  position   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  status_id  :integer
#

class Service < ActiveRecord::Base

  validates :name, :presence => true
  validates :permalink, :presence => true, :uniqueness => true, :slug => true
  validates :status_id, :presence => true

  default_value :permalink, -> { self.name.parameterize }
  default_value :status_id, -> { ServiceStatus.default.try(:id) }
  default_value :position, -> {
    last_position = self.class.order(:position => :desc).pluck(:position).first
    self.position = last_position ? last_position + 1 : 1
  }

  belongs_to :status, :class_name => 'ServiceStatus'
  has_many :issue_service_joins, :dependent => :destroy
  has_many :issues, :through => :issue_service_joins

  scope :ordered, -> { order(:position => :asc) }

end
