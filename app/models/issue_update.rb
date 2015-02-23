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

  def update_base_issue
    if self.state
      self.issue.state = self.state
    end
    if self.service_status
      self.issue.service_status = self.service_status
    end
    self.issue.save!
  end

end
