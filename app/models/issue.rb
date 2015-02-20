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
#  user_id           :integer
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
  belongs_to :user
  has_many :issue_service_joins, :dependent => :destroy
  has_many :services, :through => :issue_service_joins
  has_many :updates, :dependent => :destroy, :class_name => 'IssueUpdate'
  has_one :latest_update, -> { order(:id => :desc) }, :class_name => 'IssueUpdate'

  after_create :add_initial_update
  after_save :update_service_statuses

  def add_initial_update
    if self.initial_update.blank? && self.updates.empty?
      self.updates.create!(:state => self.state, :service_status => self.service_status, :user => self.user, :text => INITIAL_UPDATE_TEXT)
    else
      self.updates.create!(:state => self.state, :service_status => self.service_status, :user => self.user, :text => self.initial_update)
    end
  end

  def update_service_statuses
    if self.service_status_id_changed?
      self.services.each do |service|
        service.status = self.service_status
        service.save
      end
    end
  end

end
