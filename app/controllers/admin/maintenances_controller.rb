class Admin::MaintenancesController < Admin::BaseController

  before_action { params[:id] && @maintenance = Maintenance.find(params[:id]) }

  def index
    @maintenances = Maintenance.open.ordered
  end

  def completed
    @maintenances = Maintenance.closed
  end

  def show
    @update = @maintenance.updates.build(:notify => true)
    @updates = @maintenance.updates.ordered
  end

  def new
    @maintenance = Maintenance.new(:notify => true)
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

  def toggle
    if @maintenance.closed?
      @maintenance.open
      redirect_to [:admin, @maintenance], :notice => "Maintenance session has been marked as in progress successfully."
    else
      @maintenance.close
      redirect_to [:admin, @maintenance], :notice => "Maintenance session has been finished successfully."
    end
  end

  def destroy
    @maintenance.destroy
    redirect_to admin_maintenances_path, :notice => "Maintenance session has been removed successfully."
  end

  private

  def safe_params
    params.require(:maintenance).permit(:title, :description, :start_at_as_string, :length_in_minutes_as_string, :auto_close_on_completion, :service_status_id, :notify, :service_ids => [])
  end

end
