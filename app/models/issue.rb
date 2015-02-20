# == Schema Information
#
# Table name: issues
#
#  id                :integer          not null, primary key
#  title             :string(255)
#  state             :string(255)
#  service_status_id :integer
#  all_services      :boolean          default("1")
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

class Issue < ActiveRecord::Base

  attr_accessor :initial_update
  INITIAL_UPDATE_TEXT = "We're currently aware of the issue and are investigating the cause. We will provide further updates as we have them."

  STATES = ['investigating', 'identified', 'monitoring', 'resolved']

  validates :title, :presence => true
  validates :state, :inclusion => {:in => STATES}
  validates :service_status_id, :presence => true

  scope :ordered, -> { order(:id => :desc) }
  scope :ongoing, -> { where.not(:state => 'resolved') }
  scope :resolved, -> { where(:state => 'resolved') }

  belongs_to :service_status
  has_many :issue_service_joins, :dependent => :destroy
  has_many :services, :through => :issue_service_joins

end
