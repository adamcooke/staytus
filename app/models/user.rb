# == Schema Information
#
# Table name: users
#
#  id               :integer          not null, primary key
#  email_address    :string
#  name             :string
#  password_digest  :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  icon             :string
#  user_id          :string
#  last_log_on      :datetime
#  last_log_off     :datetime
#  current_group_id :bigint
#  first_name       :string
#  last_name        :string
#
# Indexes
#
#  index_users_on_current_group_id  (current_group_id)
#  index_users_on_user_id           (user_id)
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

  def self.seed
    seed_data.each do |user_attributes|
      user_id = user_attributes[:user_id]
      next if find_by_user_id(user_id)
      user = create(user_attributes)
      # user.miq_groups = [group] if group
      user.save
    end
  end

  def self.seed_file_name
    @seed_file_name ||= Rails.root.join("db", "fixtures", "#{table_name}.yaml")
  end
  private_class_method :seed_file_name

  def self.seed_data
    File.exist?(seed_file_name) ? YAML.load_file(seed_file_name) : []
  end
  private_class_method :seed_data
end
