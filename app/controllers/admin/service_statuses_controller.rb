class Admin::ServiceStatusesController < Admin::BaseController

  before_filter { params[:id] && @service_status = ServiceStatus.find(params[:id]) }

  def index
    @service_statuses = ServiceStatus.ordered.sort_by_type
  end

  def new
    @service_status = ServiceStatus.new
  end

  def create
    @service_status = ServiceStatus.new(safe_params)
    if @service_status.save
      redirect_to admin_service_statuses_path, :notice => "#{@service_status.name} has been added successfully."
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @service_status.update_attributes(safe_params)
      redirect_to admin_service_statuses_path, :notice => "#{@service_status.name} has been updated successfully."
    else
      render 'edit'
    end
  end

  def destroy
    @service_status.destroy
    redirect_to admin_service_statuses_path, :notice => "#{@service_status.name} has been removed successfully."
  rescue ActiveRecord::DeleteRestrictionError => e
    redirect_to edit_admin_service_status_path(@service_status), :alert => "You cannot remove this status because it is assigned to services. If you unassign this from all services, you can remove it from here."
  end

  private

  def safe_params
    params.require(:service_status).permit(:auto)
  end

end
