class PagesController < ApplicationController

  before_filter { prepend_view_path(File.join(Staytus::Config.theme_root, 'views')) }
  layout 'frontend'

  def index
    @services = Service.ordered.includes(:status, {:active_maintenances => :service_status}).to_a
    @issues = Issue.ongoing.ordered.to_a
    @maintenances = Maintenance.open.ordered.to_a
  end

  def issue
    @issue = Issue.find_by_identifier!(params[:id])
    @updates = @issue.updates.includes(:user).ordered
  end

  def maintenance
    @maintenance = Maintenance.find_by_identifier!(params[:id])
    @updates = @maintenance.updates.includes(:user).ordered
  end

  def history
    @issues = Issue.resolved.limit(30).to_a.map { |i| HistoryItem.new(i) }
    @maintenances = Maintenance.closed.limit(30).to_a.map { |i| HistoryItem.new(i) }
    @items = (@issues | @maintenances).sort_by(&:date).reverse.group_by(&:month)
  end

end
