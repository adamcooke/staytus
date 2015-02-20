# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  email_address   :string(255)
#  name            :string(255)
#  password_digest :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#



class User < ActiveRecord::Base

  validates :email_address, :presence => true, :email => true
  validates :name, :presence => true

  has_secure_password

  scope :ordered, -> { order(:name => :asc) }

  def self.authenticate(email, password)
    user = self.where(:email_address => email).first
    return :no_user unless user
    return :invalid_password unless user.authenticate(password)
    user
  end

end
