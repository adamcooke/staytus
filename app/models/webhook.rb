# == Schema Information
#
# Table name: webhooks
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  url      :string(255)


class Webhook < ActiveRecord::Base

  validates :name, :presence => true
  validates :url, :presence => true


  scope :ordered, -> { order(:name => :asc) }

end
