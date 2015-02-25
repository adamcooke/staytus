# == Schema Information
#
# Table name: api_tokens
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  token      :string(255)
#  secret     :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class ApiToken < ActiveRecord::Base

  validates :name, :presence => true
  validates :token, :presence => true
  validates :secret, :presence => true

  random_string :token, :type => :uuid, :unique => true
  random_string :secret, :type => :chars, :length => 30

  scope :ordered, -> { order(:name => :asc) }

end
