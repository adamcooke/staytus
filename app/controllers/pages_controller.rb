class PagesController < ApplicationController

  before_filter { prepend_view_path(File.join(Staytus::Config.theme_root, 'views')) }
  layout 'frontend'

  def index
    @services = Service.ordered.includes(:status, {:active_maintenances => :service_status})
  end

end
