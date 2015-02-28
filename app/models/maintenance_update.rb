# == Schema Information
#
# Table name: maintenance_updates
#
#  id             :integer          not null, primary key
#  maintenance_id :integer
#  user_id        :integer
#  text           :text(65535)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  identifier     :string(255)
#  notify         :boolean          default("0")
#

class MaintenanceUpdate < ActiveRecord::Base

  belongs_to :maintenance
  belongs_to :user

  validates :text, :presence => true

  random_string :identifier, :type => :hex, :length => 6, :unique => true

  scope :ordered, -> { order(:id => :desc) }

  after_commit :send_notifications_on_create, :on => :create

  florrick do
    string :text
    string :identifier
    relationship :maintenance
    relationship :user
  end

  def send_notifications
    for subscriber in Subscriber.verified
      Staytus::Email.deliver(subscriber, :new_maintenance_update, :maintenance => self.maintenance, :update => self)
    end
  end

  def send_notifications_on_create
    if self.notify?
      self.delay.send_notifications
    end
  end

end
