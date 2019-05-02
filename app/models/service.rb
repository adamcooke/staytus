# == Schema Information
#
# Table name: services
#
#  id          :integer          not null, primary key
#  name        :string
#  permalink   :string
#  position    :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  status_id   :integer
#  description :text
#  group_id    :integer
#

class Service < ActiveRecord::Base

  validates :name, :presence => true
  validates :permalink, :presence => true, :uniqueness => true, :slug => true
  validates :status_id, :presence => true
  validates :description, :length => {:maximum => 1000}

  default_value :permalink, -> { self.name.parameterize }
  default_value :status_id, -> { ServiceStatus.default.try(:id) }
  default_value :position, -> {
    last_position = self.class.order(:position => :desc).pluck(:position).first
    self.position = last_position ? last_position + 1 : 1
  }

  belongs_to :status, :class_name => 'ServiceStatus'
  belongs_to :group, :class_name => 'ServiceGroup'
  has_many :issue_service_joins, :dependent => :destroy
  has_many :issues, :through => :issue_service_joins
  has_many :maintenance_service_joins, :dependent => :destroy
  has_many :maintenances, :through => :maintenance_service_joins
  has_many :active_maintenances, -> { references(:maintenances).where(:closed_at => nil).where("start_at <= ?", Time.now) }, :through => :maintenance_service_joins, :source => :maintenance

  scope :ordered, -> { order(:position => :asc) }

  def self.seed
    seed_data[:services].each do |service_name|
      next if find_by_name(service_name)
      service = create(name: service_name)
      service.save
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
