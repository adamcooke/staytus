# == Schema Information
#
# Table name: maintenances
#
#  id                :integer          not null, primary key
#  title             :string(255)
#  description       :text(65535)
#  start_at          :datetime
#  finish_at         :datetime
#  length_in_minutes :integer
#  closed            :boolean          default("0")
#  user_id           :integer
#  service_status_id :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

class Maintenance < ActiveRecord::Base

  belongs_to :user
  belongs_to :service_status

  validates :title, :presence => true
  validates :description, :presence => true
  validates :service_status_id, :presence => true
  validates :start_at, :presence => true
  validates :finish_at, :presence => true
  validates :length_in_minutes, :numericality => {:greater_than_or_equal_to => 30, :message => "must be at least half an hour"}

  has_many :maintenance_service_joins, :dependent => :destroy
  has_many :services, :through => :maintenance_service_joins
  has_many :updates, :dependent => :destroy, :class_name => 'MaintenanceUpdate'

  scope :open, -> { where(:closed => false) }
  scope :ordered, -> { order(:start_at => :asc) }
  scope :active_now, -> { where("start_at <= ? AND closed = ?", Time.now, false) }

  before_validation :convert_times

  def status
    return :closed if self.closed?
    self.start_at > Time.now ? :upcoming : :active
  end

  def open?
    !closed?
  end

  def open
    self.closed = false
    self.save
  end

  def close
    self.closed = true
    self.save
  end

  def start_at_as_string
    @start_at_as_string ||= self.start_at ? self.start_at.to_s(:db) : nil
  end

  def start_at_as_string=(string)
    @start_at_as_string = string
    self.start_at = Chronic.parse(string)
  end

  def length_in_minutes_as_string
    @length_in_minutes_as_string ||= self.length_in_minutes ? ChronicDuration.output(self.length_in_minutes * 60, :format => :long) : nil
  end

  def length_in_minutes_as_string=(string)
    @length_in_minutes_as_string = string
    if string =~ /\A(\d+)\z/
      self.length_in_minutes = string.to_i
    elsif parsed_time = ChronicDuration.parse(string)
      self.length_in_minutes = parsed_time / 60
    else
      self.length_in_minutes = nil
    end
  end

  private

  def convert_times
    # Set the finish time based on the start time and the
    # length of the session
    if self.start_at && self.length_in_minutes
      self.finish_at = self.start_at + (self.length_in_minutes * 60)
    end
  end

end
