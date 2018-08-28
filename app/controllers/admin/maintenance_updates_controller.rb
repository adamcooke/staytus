class Admin::MaintenanceUpdatesController < Admin::BaseController

  before_action { @maintenance = Maintenance.find(params[:maintenance_id]) }
  before_action { params[:id] && @maintenance_update = @maintenance.updates.find(params[:id]) }

  def create
    @update = @maintenance.updates.build(safe_params)
    @update.user = current_user
    if @update.save
      redirect_to admin_maintenance_path(@maintenance), :notice => "Update has been posted successfully."
    else
      redirect_to admin_maintenance_path(@maintenance), :alert => @update.errors.full_messages.to_sentence
    end
  end

  def update
    if @maintenance_update.update(safe_params)
      redirect_to admin_maintenance_path(@maintenance), :notice => "Update has been updated successfully."
    else
      render 'edit'
    end
  end

  def destroy
    @maintenance_update.destroy
    redirect_to admin_maintenance_path(@maintenance), :notice => "Update has been removed successfully."
  end

  private

  def safe_params
    params.require(:maintenance_update).permit(:text, :notify)
  end

end
