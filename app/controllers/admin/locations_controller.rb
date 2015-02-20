class Admin::LocationsController < Admin::BaseController

  before_filter { params[:id] && @location = Location.find(params[:id]) }

  def index
    @locations = Location.ordered
  end

  def new
    @location = Location.new
  end

  def create
    @location = Location.new(safe_params)
    if @location.save
      redirect_to admin_locations_path, :notice => "#{@location.name} has been added successfully."
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @location.update_attributes(safe_params)
      redirect_to admin_locations_path, :notice => "#{@location.name} has been updated successfully."
    else
      render 'edit'
    end
  end

  def destroy
    @location.destroy
    redirect_to admin_locations_path, :notice => "#{@location.name} has been removed successfully."
  end

  private

  def safe_params
    params.require(:location).permit(:auto, :service_ids => [])
  end

end
