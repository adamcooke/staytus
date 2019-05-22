# == Schema Information
#
# Table name: service_groups
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class ServiceGroup < ActiveRecord::Base

  validates :name, :presence => true
  scope :ordered, -> { order(:name => :asc) }

  has_many :services, :dependent => :nullify, :foreign_key => 'group_id'

  def self.seed
    seed_data[:service_groups].each do |service_group|
      next if find_by_name(service_group)
      service_group = create(name: service_group)
      service_group.save
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
