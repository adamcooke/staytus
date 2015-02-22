class Admin::DashboardController < Admin::BaseController

  def index
    @services = Service.ordered.includes(:status, {:active_maintenances => :service_status})
  end

end
