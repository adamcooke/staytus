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
#  identifier        :string(255)
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

  random_string :identifier, :type => :uuid, :unique => true

  belongs_to :service_status
  belongs_to :user
  has_many :issue_service_joins, :dependent => :destroy
  has_many :services, :through => :issue_service_joins
  has_many :updates, :dependent => :destroy, :class_name => 'IssueUpdate'
  has_one :latest_update, -> { order(:id => :desc) }, :class_name => 'IssueUpdate'

  after_create :add_initial_update
  after_save :update_service_statuses
  after_create :create_history_item
  after_destroy :destroy_history_item

  def add_initial_update
    update = self.updates.build(:state => self.state, :service_status => self.service_status, :user => self.user, :created_at => self.created_at)
    if self.initial_update.blank? && self.updates.empty?
      update.text = INITIAL_UPDATE_TEXT
    else
      update.text = self.initial_update
    end
    update.save!
  end

  def update_service_statuses
    if self.service_status_id_changed?
      self.services.each do |service|
        service.status = self.service_status
        service.save
      end
    end
  end

  private

  def create_history_item
    HistoryItem.create(:item => self, :date => self.created_at)
  end

  def destroy_history_item
    HistoryItem.where(:item => self).destroy_all
  end

end
