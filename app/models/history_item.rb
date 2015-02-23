class HistoryItem

  def initialize(item)
    @item = item
  end

  def date
    @item.is_a?(Maintenance) ? @item.start_at : @item.created_at
  end

  def link
    @item.is_a?(Maintenance) ? "/maintenance/#{@item.identifier}" : "/issue/#{@item.identifier}"
  end

  def title
    @item.title
  end

  def type
    @item.class.name
  end

  def month
    @month ||= Date.new(date.year, date.month)
  end

end
