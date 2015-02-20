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

class IssueServiceJoin < ActiveRecord::Base
  belongs_to :issue
  belongs_to :service
end
