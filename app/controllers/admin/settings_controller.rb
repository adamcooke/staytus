class Admin::SettingsController < Admin::BaseController

  def edit
    @site = Site.find(site.id)
  end

  def design
    @site = Site.find(site.id)
  end

  def update
    @site = Site.find(site.id)
    if @site.update_attributes(params.require(:site).permit(:title, :domain, :description, :support_email, :website_url, :time_zone, :http_protocol, :crawling_permitted, :allow_subscriptions, :email_from_name, :email_from_address, :logo_file, :logo_delete, :cover_image_file, :cover_image_delete, :privacy_policy_url))
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
