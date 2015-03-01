# == Schema Information
#
# Table name: email_templates
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  subject    :string(255)
#  content    :text(65535)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class EmailTemplate < ActiveRecord::Base

  validates :name, :presence => true
  validates :subject, :presence => true
  validates :content, :presence => true

  def self.body_for(name)
    if template = self.where(:name =>name).select(:content).first
      template.content
    end
  end

  def self.subject_for(name)
    if template = self.where(:name =>name).select(:subject).first
      template.subject
    end
  end

end
