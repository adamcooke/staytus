class Admin::SettingsController < Admin::BaseController

  def edit
    @site = Site.find(site.id)
  end

  def update
    @site = Site.find(site.id)
    if @site.update_attributes(params.require(:site).permit(:auto))
      redirect_to admin_settings_path, :notice => "Settings have been saved successfully."
    else
      render 'edit'
    end
  end

end
