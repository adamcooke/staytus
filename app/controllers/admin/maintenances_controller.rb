class Admin::MaintenancesController < Admin::BaseController

  before_filter { params[:id] && @maintenance = Maintenance.find(params[:id]) }

  def index
    @maintenances = Maintenance.open
  end

  def new
    @maintenance = Maintenance.new
  end

  def create
    @maintenance = Maintenance.new(safe_params)
    if @maintenance.save
      redirect_to admin_maintenances_path, :notice => "Maintenance session has been added successfully."
    else
      render 'new'
    end
  end

  def update
    if @maintenance.update(safe_params)
      redirect_to [:admin, @maintenance], :notice => "Maintenance session has been updated successfully."
    else
      render 'edit'
    end
  end

  def close
    @maintenance.close
    redirect_to admin_maintenances_path, :notice => "Maintenance session has been closed successfully."
  end

  def destroy
    @maintenance.destroy
    redirect_to admin_maintenances_path, :notice => "Maintenance session has been removed successfully."
  end

  private

  def safe_params
    params.require(:maintenance).permit(:auto, :service_ids => [])
  end

end
