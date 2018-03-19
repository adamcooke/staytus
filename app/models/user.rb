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

  include Authie::User
  include LogLogins::User

  validates :email_address, :presence => true, :email => true
  validates :name, :presence => true

  has_many :issues, :dependent => :nullify
  has_many :issue_updates, :dependent => :nullify
  has_many :maintenances, :dependent => :nullify
  has_many :maintenance_updates, :dependent => :nullify

  has_secure_password

  scope :ordered, -> { order(:name => :asc) }

  florrick do
    string :email_address
    string :name
  end

  def self.authenticate(email, password, ip)
    user = self.where(:email_address => email).first
    unless user
      LogLogins.fail(email, nil, ip)
      return :no_user
    end

    unless user.authenticate(password)
      LogLogins.fail(email, user, ip)
      return :invalid_password
    end

    LogLogins.success(email, user, ip)
    user
  end

end
