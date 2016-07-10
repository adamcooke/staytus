class Admin::ServiceGroupsController < Admin::BaseController

  before_filter { params[:id] && @service_group = ServiceGroup.find(params[:id]) }

  def index
    @service_groups = ServiceGroup.ordered
  end

  def new
    @service_group = ServiceGroup.new
  end

  def create
    @service_group = ServiceGroup.new(safe_params)
    if @service_group.save
      redirect_to admin_service_groups_path, :notice => "#{@service_group.name} has been added successfully."
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @service_group.update_attributes(safe_params)
      redirect_to admin_service_groups_path, :notice => "#{@service_group.name} has been updated successfully."
    else
      render 'edit'
    end
  end

  def destroy
    @service_group.destroy
    redirect_to admin_service_groups_path, :notice => "#{@service_group.name} has been removed successfully."
  rescue ActiveRecord::DeleteRestrictionError => e
    redirect_to edit_admin_service_group_path(@service_group), :alert => "You cannot remove this group because it is assigned to services. If you unassign this from all services, you can remove it from here."
  end

  private

  def safe_params
    params.require(:service_group).permit(:auto)
  end

end
