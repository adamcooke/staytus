# == Schema Information
#
# Table name: issue_service_joins
#
#  id         :integer          not null, primary key
#  issue_id   :integer
#  service_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_issue_service_joins_on_issue_id                 (issue_id)
#  index_issue_service_joins_on_issue_id_and_service_id  (issue_id,service_id) UNIQUE
#  index_issue_service_joins_on_service_id               (service_id)
#

class IssueServiceJoin < ActiveRecord::Base
  belongs_to :issue
  belongs_to :service

  validates :issue_id, :uniqueness => { :scope => :service_id }
  validates :issue_id, :service_id, presence: true

end
