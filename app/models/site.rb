# == Schema Information
#
# Table name: sites
#
#  id            :integer          not null, primary key
#  title         :string(255)
#  description   :string(255)
#  domain        :string(255)
#  support_email :string(255)
#  website_url   :string(255)
#

class Site < ActiveRecord::Base

  validates :title, :presence => true
  validates :description, :presence => true
  validates :domain, :presence => true
  validates :support_email, :presence => true, :email => true
  validates :website_url, :presence => true, :url => true

end
