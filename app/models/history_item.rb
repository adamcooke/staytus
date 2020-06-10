# == Schema Information
#
# Table name: history_items
#
#  id        :integer          not null, primary key
#  item_type :string(255)
#  item_id   :integer
#  date      :datetime
#
# Indexes
#
#  index_history_items_on_item_id_and_item_type  (item_id,item_type)
#

class HistoryItem < ActiveRecord::Base

  belongs_to :item, :polymorphic => true

  scope :ordered, -> { order(:date => :desc) }

  def month
    @month ||= Date.new(date.year, date.month)
  end

  def link
    item.is_a?(Maintenance) ? "/maintenance/#{item.identifier}" : "/issue/#{item.identifier}"
  end

  def title
    item.title
  end

  def type
    item_type
  end

end
