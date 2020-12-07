# == Schema Information
#
# Table name: subscriber_service_joins
#
#  id            :integer          not null, primary key
#  subscriber_id :integer
#  service_id    :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class SubscriberServiceJoin < ActiveRecord::Base

  belongs_to :subscriber
  belongs_to :service

end
