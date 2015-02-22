class Admin::ServicesController < Admin::BaseController

  before_filter { params[:id] && @service = Service.find(params[:id]) }

  def index
    @services = Service.ordered.includes(:status, {:active_maintenances => :service_status})
  end

  def new
    @service = Service.new
  end

  def create
    @service = Service.new(safe_params)
    if @service.save
      redirect_to admin_services_path, :notice => "#{@service.name} has been added successfully."
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @service.update_attributes(safe_params)
      redirect_to admin_services_path, :notice => "#{@service.name} has been updated successfully."
    else
      render 'edit'
    end
  end

  def destroy
    @service.destroy
    redirect_to admin_services_path, :notice => "#{@service.name} has been removed successfully."
  end

  private

  def safe_params
    params.require(:service).permit(:auto)
  end

end
