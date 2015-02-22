class Admin::SettingsController < Admin::BaseController

  def edit
    @site = Site.find(site.id)
  end

  def design
    @site = Site.find(site.id)
  end

  def update
    @site = Site.find(site.id)
    if @site.update_attributes(params.require(:site).permit(:auto, :logo_delete, :cover_image_delete))
      redirect_to redirection_path_for(params[:return_to]), :notice => "Settings have been saved successfully."
    else
      render form_render_for(params[:return_to])
    end
  end

  private

  def form_render_for(return_to)
    case return_to
    when 'design' then 'design'
    else 'edit'
    end
  end

  def redirection_path_for(return_to)
    case return_to
    when 'design' then admin_settings_design_path
    else admin_settings_path
    end
  end

end
