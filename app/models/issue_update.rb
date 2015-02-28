# == Schema Information
#
# Table name: issue_updates
#
#  id                :integer          not null, primary key
#  issue_id          :integer
#  user_id           :integer
#  service_status_id :integer
#  state             :string(255)
#  text              :text(65535)
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  identifier        :string(255)
#  notify            :boolean          default("0")
#

class IssueUpdate < ActiveRecord::Base

  validates :state, :inclusion => {:in => Issue::STATES, :allow_blank => true}
  validates :text, :presence => true

  belongs_to :issue
  belongs_to :user
  belongs_to :service_status

  random_string :identifier, :type => :hex, :length => 6, :unique => true

  scope :ordered, -> { order(:id => :desc) }

  after_save :update_base_issue
  after_commit :send_notifications_on_create, :on => :create

  florrick do
    string :state
    string :text
    string :identifier
    string :created_at
    string :updated_at
    relationship :service_status
    relationship :user
    relationship :issue
  end

  def update_base_issue
    if self.state
      self.issue.state = self.state
    end
    if self.service_status
      self.issue.service_status = self.service_status
    end
    self.issue.save!
  end

  def send_notifications
    for subscriber in Subscriber.verified
      Staytus::Email.deliver(subscriber, :new_issue_update, :issue => self.issue, :update => self)
    end
  end

  def send_notifications_on_create
    if self.notify?
      delay.send_notifications
    end
  end

end
