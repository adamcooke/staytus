class SetupController < ApplicationController
  skip_before_filter :ensure_site
  layout 'admin'

  before_filter do
    if has_site?
      redirect_to admin_root_path, :alert => "You already have configured this installation."
    end
  end

  def step2
    if User.first
      redirect_to setup_path(:step3)
    end

    if request.post?
      @user = User.new(params.require(:user).permit(:auto))
      if @user.save
        redirect_to setup_path(:step3), :notice => "Great! You will be able to login using those details when this wizard is complete."
      else
        render 'step2'
      end
    else
      @user = User.new
    end
  end

  def step3
    if request.post?
      @new_site = Site.new(params.require(:site).permit(:auto))
      @new_site.http_protocol = request.protocol.gsub('://', '')
      if @new_site.save
        ServiceStatus.create_defaults
        Service.create_defaults
        self.current_user = User.first
        redirect_to admin_root_path, :notice => "You're all done! You can go ahead and explore! We've logged you in as the user you just created."
      else
        render 'step3'
      end
    else
      @new_site = Site.new(:domain => request.host, :time_zone => "UTC")
    end
  end
end
